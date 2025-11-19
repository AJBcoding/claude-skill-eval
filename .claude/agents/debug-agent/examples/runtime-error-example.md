# Example: Debugging a Runtime Error

This example demonstrates the 6-step debugging methodology applied to a Python runtime error.

---

## Scenario

**User Request**: "Run the data processing script"

**Command Executed**:
```bash
python scripts/process_data.py --input data.csv
```

**Error Output**:
```
Processing data from data.csv...
Loaded 1000 records
Starting transformation...
Traceback (most recent call last):
  File "scripts/process_data.py", line 45, in <module>
    result = transform_records(records)
  File "scripts/process_data.py", line 23, in transform_records
    transformed = [transform_record(r) for r in records]
  File "scripts/process_data.py", line 23, in <listcomp>
    transformed = [transform_record(r) for r in records]
  File "scripts/process_data.py", line 15, in transform_record
    return {
  File "scripts/process_data.py", line 17, in <dictcomp>
    'value': float(record['amount'])
ValueError: could not convert string to float: '1,234.56'
```

**Exit Code**: 1 (Python exception)

---

## Debugging Session

### STEP 1: Reproduce ✓

**Objective**: Establish reliable reproduction of the error

**Actions Taken**:
1. Read complete stack trace
2. Note exact error type and message
3. Identify input data that triggers error
4. Verify consistent reproduction

**Stack Trace Analysis**:
- **Error Type**: ValueError
- **Error Message**: "could not convert string to float: '1,234.56'"
- **Location**: process_data.py line 17
- **Function Chain**: main → transform_records → transform_record
- **Problematic Value**: '1,234.56' (string with comma separator)

**Input Data Check**:
```bash
# Examine the input data
head -20 data.csv

# Output:
id,name,amount,date
1,Widget,1234.56,2024-01-01
2,Gadget,2345.67,2024-01-02
3,Item,"1,234.56",2024-01-03  # ← Note: Quoted field with comma
4,Product,3456.78,2024-01-04
...
```

**Reproduction Steps**:
```bash
# Create minimal test file
echo 'id,name,amount,date' > test_minimal.csv
echo '1,Test,"1,234.56",2024-01-01' >> test_minimal.csv

# Run script with test file
python scripts/process_data.py --input test_minimal.csv

# Error reproduces consistently
```

**Reproduction Documentation**:
```markdown
**Error Message**: ValueError: could not convert string to float: '1,234.56'
**Error Type**: ValueError (type conversion failure)
**Trigger Conditions**:
  - Input CSV contains amount field with comma thousand separator
  - Field is quoted: "1,234.56"
  - float() conversion fails on comma-formatted numbers

**Reproduction Steps**:
1. Create CSV with amount field containing comma: "1,234.56"
2. Run process_data.py with that CSV
3. Error occurs at transform_record when converting to float

**Consistency**: Fails every time on records with comma-formatted amounts
**Data Pattern**: Row 3 in data.csv triggers error
```

---

### STEP 2: Isolate ✓

**Objective**: Narrow down to specific code causing failure

**Actions Taken**:
1. Read the transform_record function
2. Identify the exact line failing
3. Understand the data flow
4. Check how data is read from CSV

**Code Examination** (process_data.py):
```python
import csv

def load_records(filename):
    """Load records from CSV file"""
    with open(filename, 'r') as f:
        reader = csv.DictReader(f)
        return list(reader)

def transform_record(record):
    """Transform a single record"""
    return {
        'id': int(record['id']),
        'name': record['name'],
        'value': float(record['amount']),  # ← LINE 17: FAILS HERE
        'date': record['date']
    }

def transform_records(records):
    """Transform all records"""
    transformed = [transform_record(r) for r in records]
    return transformed

def main():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--input', required=True)
    args = parser.parse_args()

    print(f"Processing data from {args.input}...")
    records = load_records(args.input)
    print(f"Loaded {len(records)} records")

    print("Starting transformation...")
    result = transform_records(records)
    print(f"Transformed {len(result)} records")

if __name__ == '__main__':
    main()
```

**Problematic Line**:
```python
'value': float(record['amount']),  # Line 17
```

**Data Flow**:
1. CSV loaded by csv.DictReader → strings
2. record['amount'] = "1,234.56" (string with comma)
3. float("1,234.56") → ValueError

**Isolation Summary**:
```markdown
**Location**: process_data.py:17 (transform_record function)
**Scope**: float() conversion of amount field
**Root Line**: `'value': float(record['amount'])`

**Context**:
- CSV values read as strings
- Some amount values contain comma thousand separators
- Python's float() doesn't handle comma separators
- No preprocessing of amount field before conversion

**Related Code**: Only this function converts amounts
**Recent Changes**: None (git log shows no recent edits)
```

---

### STEP 3: Hypothesis ✓

**Objective**: Form theory about root cause and solution

**Primary Theory**:
The error occurs because Python's `float()` function cannot parse numbers with
thousand separators (commas). The CSV contains amounts like "1,234.56" which
are valid representations but need the comma removed before conversion.

The solution is to strip commas from the amount string before calling float().

**Evidence Supporting Hypothesis**:
1. Error message: "could not convert string to float: '1,234.56'"
2. Python documentation: float() accepts numbers without formatting
3. Test confirms: `float("1,234.56")` raises ValueError
4. Test confirms: `float("1234.56")` succeeds
5. CSV data shows amounts with commas in quotes

**Alternative Theories**:

1. **Wrong data type in CSV** - Likelihood: Low
   - Data is correct (valid number representation)
   - Problem is format, not content
   - Other systems accept comma-formatted numbers

2. **Encoding issue** - Likelihood: Very Low
   - Error clearly shows ASCII comma character
   - Not a character encoding problem
   - Can see exact string in error message

3. **Use locale-aware parsing** - Likelihood: Medium
   - Could use locale.atof() instead
   - More complex than needed
   - Simple string replacement works

**Predicted Implications**:
If removing commas before float() conversion:
- float("1,234.56".replace(",", "")) → 1234.56 ✓
- Works for numbers with or without commas
- No impact on already-valid numbers
- Handles thousands, millions, etc.

**Testing Hypothesis Mentally**:
```python
# Current (fails):
float("1,234.56")  # ValueError

# Proposed (should work):
float("1,234.56".replace(",", ""))  # 1234.56

# Edge cases:
float("1234.56".replace(",", ""))  # 1234.56 (no change)
float("1,234,567.89".replace(",", ""))  # 1234567.89
```

---

### STEP 4: Test ✓

**Objective**: Validate hypothesis before changing production code

**Test Method**: Create a test script to validate the solution

**Validation Script** (test_float_conversion.py):
```python
def test_float_conversion():
    """Test float conversion with comma removal"""

    test_cases = [
        ("1234.56", 1234.56),           # No comma
        ("1,234.56", 1234.56),          # Single comma
        ("1,234,567.89", 1234567.89),   # Multiple commas
        ("0.99", 0.99),                 # Less than 1
        ("1000", 1000.0),               # Integer
        ("1,000", 1000.0),              # Integer with comma
    ]

    print("Testing float conversion with comma removal:\n")

    for input_str, expected in test_cases:
        try:
            # Test current approach (should fail for comma-containing)
            try:
                result_direct = float(input_str)
                status_direct = "✓"
            except ValueError:
                result_direct = None
                status_direct = "✗"

            # Test proposed approach (should always work)
            result_cleaned = float(input_str.replace(",", ""))
            status_cleaned = "✓" if result_cleaned == expected else "✗"

            print(f"Input: {input_str:>15}")
            print(f"  Direct float():        {status_direct} {result_direct}")
            print(f"  With comma removal:    {status_cleaned} {result_cleaned}")
            print(f"  Expected:              {expected}")
            print()

        except Exception as e:
            print(f"Input: {input_str} - UNEXPECTED ERROR: {e}\n")

if __name__ == '__main__':
    test_float_conversion()
```

**Test Results**:
```
Testing float conversion with comma removal:

Input:         1234.56
  Direct float():        ✓ 1234.56
  With comma removal:    ✓ 1234.56
  Expected:              1234.56

Input:        1,234.56
  Direct float():        ✗ None
  With comma removal:    ✓ 1234.56
  Expected:              1234.56

Input:     1,234,567.89
  Direct float():        ✗ None
  With comma removal:    ✓ 1234567.89
  Expected:              1234567.89

Input:            0.99
  Direct float():        ✓ 0.99
  With comma removal:    ✓ 0.99
  Expected:              0.99

Input:            1000
  Direct float():        ✓ 1000.0
  With comma removal:    ✓ 1000.0
  Expected:              1000.0

Input:           1,000
  Direct float():        ✗ None
  With comma removal:    ✓ 1000.0
  Expected:              1000.0
```

**Hypothesis Status**: **✓ CONFIRMED**

The `.replace(",", "")` approach successfully handles all test cases:
- Works for numbers with commas (fixes the bug)
- Works for numbers without commas (no regression)
- Works for multiple commas
- Works for all numeric formats in our data

**Edge Cases Checked**:
- ✓ No comma: "1234.56" → 1234.56
- ✓ One comma: "1,234.56" → 1234.56
- ✓ Multiple commas: "1,234,567.89" → 1234567.89
- ✓ Decimal only: "0.99" → 0.99
- ✓ Integer: "1000" → 1000.0
- ✓ Integer with comma: "1,000" → 1000.0

**Potential Issues**:
- European format (1.234,56) would break - but not in our data
- Scientific notation (1.23e4) works fine with replace
- Negative numbers ("-1,234.56") would work

---

### STEP 5: Fix ✓

**Objective**: Implement the validated solution

**Root Cause**: float() cannot parse comma thousand separators

**Fix Description**: Remove commas from amount string before float conversion

**Code Changes**:
```python
def transform_record(record):
    """Transform a single record"""
    return {
        'id': int(record['id']),
        'name': record['name'],
        # FIXED: Remove commas before float conversion
        'value': float(record['amount'].replace(',', '')),
        'date': record['date']
    }
```

**Full Diff**:
```diff
 def transform_record(record):
     """Transform a single record"""
     return {
         'id': int(record['id']),
         'name': record['name'],
-        'value': float(record['amount']),
+        'value': float(record['amount'].replace(',', '')),
         'date': record['date']
     }
```

**Similar Patterns Check**:
```bash
# Search for other float conversions
grep -n "float(" scripts/*.py

# Output:
process_data.py:17:        'value': float(record['amount'].replace(',', '')),
analytics.py:34:    percentage = float(value) / total  # Different context, no CSV
stats.py:12:    return float(num)  # Utility function

# Check stats.py utility function
```

**Additional Fix** (stats.py):
```python
# Found similar pattern in stats.py
def parse_number(num):
    """Parse number from string"""
    # ALSO FIXED: Handle comma separators here too
    if isinstance(num, str):
        return float(num.replace(',', ''))
    return float(num)
```

**Similar Patterns Fixed**: 2 locations
1. process_data.py:17 (original issue)
2. stats.py:12 (preventive fix)

**Edge Cases Handled**:
- Commas in numbers: Removed before conversion
- No commas: `.replace(',', '')` is no-op, works fine
- Multiple commas: All removed correctly
- Empty string: Would fail with float('') - addressed below

**Enhanced Fix with Error Handling**:
```python
def transform_record(record):
    """Transform a single record with error handling"""
    try:
        return {
            'id': int(record['id']),
            'name': record['name'],
            'value': float(record['amount'].replace(',', '')),
            'date': record['date']
        }
    except ValueError as e:
        # Provide helpful error message
        raise ValueError(
            f"Failed to transform record ID {record.get('id', 'unknown')}: "
            f"Invalid amount '{record.get('amount', '')}' - {e}"
        )
```

---

### STEP 6: Verify ✓

**Objective**: Confirm fix resolves issue with comprehensive testing

**Original Error**: ✓ **FIXED**

**Test Results**:

1. **Original failing data**:
```bash
python scripts/process_data.py --input data.csv

# Output:
Processing data from data.csv...
Loaded 1000 records
Starting transformation...
Transformed 1000 records
✓ Success!
```

2. **Minimal reproduction case**:
```bash
python scripts/process_data.py --input test_minimal.csv

# Output:
Processing data from data.csv...
Loaded 1 records
Starting transformation...
Transformed 1 records
✓ Success!
```

3. **Edge case: All format variations**:
```bash
# Create comprehensive test file
cat > test_formats.csv << EOF
id,name,amount,date
1,No comma,1234.56,2024-01-01
2,One comma,1,234.56,2024-01-02
3,Multiple commas,1,234,567.89,2024-01-03
4,Integer,1000,2024-01-04
5,Integer with comma,1,000,2024-01-05
6,Small decimal,0.99,2024-01-06
EOF

python scripts/process_data.py --input test_formats.csv

# Output:
Processing data from test_formats.csv...
Loaded 6 records
Starting transformation...
Transformed 6 records
✓ All formats handled correctly
```

4. **Verify output values**:
```python
# Add quick verification script
import csv
records = load_records('test_formats.csv')
result = transform_records(records)

for r in result:
    print(f"ID {r['id']}: {r['value']}")

# Output:
ID 1: 1234.56
ID 2: 1234.56
ID 3: 1234567.89
ID 4: 1000.0
ID 5: 1000.0
ID 6: 0.99

✓ All values correct
```

5. **Error handling test**:
```bash
# Create file with invalid data
cat > test_invalid.csv << EOF
id,name,amount,date
1,Bad,not_a_number,2024-01-01
EOF

python scripts/process_data.py --input test_invalid.csv

# Output:
Processing data from test_invalid.csv...
Loaded 1 records
Starting transformation...
ValueError: Failed to transform record ID 1: Invalid amount 'not_a_number' - could not convert string to float: 'not_a_number'

✓ Helpful error message provided
```

**Test Suite**: ✓ **PASS**
```bash
# Run unit tests
pytest tests/test_process_data.py -v

# Output:
test_transform_record_basic PASSED
test_transform_record_with_commas PASSED
test_transform_record_multiple_commas PASSED
test_transform_record_no_comma PASSED
test_transform_record_invalid_amount PASSED

5 passed in 0.23s
```

**Regression Check**: ✓ **No regressions**
- All existing test files process correctly
- Output values match expected results
- Performance unchanged (negligible overhead from .replace())
- No impact on records without commas

**Performance Check**:
```bash
# Process large file (10,000 records)
time python scripts/process_data.py --input large_data.csv

# Before fix: N/A (crashed on first comma)
# After fix:  2.3s for 10,000 records
✓ Acceptable performance
```

---

## Summary

**Issue**: Runtime ValueError when converting comma-formatted amounts to float
**Root Cause**: Python's float() doesn't parse thousand separators
**Fix**: Remove commas from amount string before conversion
**Impact**: Fixed 2 locations (process_data.py, stats.py)
**Verification**: All formats work, error handling improved
**Time**: ~20 minutes (systematic testing prevented incomplete fix)

---

## Lessons Learned

### What Worked Well
✓ Stack trace immediately showed exact location and problematic value
✓ Examining input data revealed the format variation
✓ Creating test cases validated solution before changing production code
✓ Searching for similar patterns caught second location
✓ Comprehensive edge case testing ensured robust fix
✓ Adding error handling improved debuggability

### Anti-Patterns Avoided

#### ❌ Trial-and-Error Approach
```python
# Bad: Randomly trying different conversions
try:
    value = float(record['amount'])
except:
    value = float(record['amount'].strip())  # Doesn't help
except:
    value = float(record['amount'].replace(' ', ''))  # Wrong character
except:
    value = float(record['amount'].replace(',', ''))  # Finally works?
```

This wastes time and leads to unclear code.

**✓ Systematic Approach**: Hypothesis → Test → Fix

---

#### ❌ Symptom Fixing
```python
# Bad: Just catch and ignore the error
try:
    value = float(record['amount'])
except ValueError:
    value = 0  # Default to zero - hides the problem!
```

This makes the error go away but corrupts data.

**✓ Root Cause Fix**: Parse the format correctly

---

#### ❌ Over-Engineering
```python
# Bad: Overly complex solution
import locale
locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')

def parse_amount(amount_str):
    # Complex parsing logic
    if ',' in amount_str and '.' in amount_str:
        # Determine which is thousand separator
        comma_pos = amount_str.rfind(',')
        dot_pos = amount_str.rfind('.')
        if comma_pos < dot_pos:
            # US format
            return locale.atof(amount_str)
        else:
            # European format
            # ... complex logic
```

This is over-engineered for our simple use case.

**✓ Simple Fix**: `.replace(',', '')` handles our data perfectly

---

### Prevention Strategies

#### 1. Input Validation
```python
def load_records(filename):
    """Load records from CSV file with validation"""
    with open(filename, 'r') as f:
        reader = csv.DictReader(f)
        records = list(reader)

    # Validate amount format
    for record in records:
        amount = record.get('amount', '')
        if not amount:
            raise ValueError(f"Missing amount in record {record['id']}")

    return records
```

#### 2. Centralized Parsing
```python
def parse_amount(amount_str):
    """Parse amount string to float, handling common formats"""
    if not amount_str:
        raise ValueError("Amount is empty")

    # Remove thousand separators (comma)
    cleaned = amount_str.replace(',', '')

    try:
        return float(cleaned)
    except ValueError as e:
        raise ValueError(f"Invalid amount format '{amount_str}': {e}")

def transform_record(record):
    """Transform a single record"""
    return {
        'id': int(record['id']),
        'name': record['name'],
        'value': parse_amount(record['amount']),  # Use centralized parser
        'date': record['date']
    }
```

Benefits:
- Single location for amount parsing logic
- Easier to test
- Consistent error messages
- Can handle format variations

#### 3. Unit Tests
```python
def test_parse_amount():
    """Test amount parsing with various formats"""
    assert parse_amount("1234.56") == 1234.56
    assert parse_amount("1,234.56") == 1234.56
    assert parse_amount("1,234,567.89") == 1234567.89

    with pytest.raises(ValueError):
        parse_amount("")

    with pytest.raises(ValueError):
        parse_amount("invalid")
```

#### 4. Data Validation at Source
```python
# Add to data ingestion pipeline
def validate_csv_format(filename):
    """Validate CSV format before processing"""
    with open(filename, 'r') as f:
        reader = csv.DictReader(f)
        required_fields = ['id', 'name', 'amount', 'date']

        # Check headers
        if not all(field in reader.fieldnames for field in required_fields):
            raise ValueError(f"CSV missing required fields: {required_fields}")

        # Sample check first row
        first_row = next(reader)
        parse_amount(first_row['amount'])  # Validates format

    return True
```

---

## Key Takeaways

### For Runtime Errors Generally

1. **Read stack traces completely** - Line numbers and values are clues
2. **Examine actual data** - Look at real input causing the error
3. **Test hypotheses** - Validate before changing production code
4. **Search for patterns** - One bug often exists in multiple places
5. **Add error handling** - Make future errors easier to debug
6. **Centralize parsing** - Reusable functions prevent duplication

### For Data Type Conversions Specifically

- float(), int() are strict - don't handle formatting
- .replace() for simple cleaning is often sufficient
- Locale-aware parsing is complex - use when needed
- Validate at ingestion, not conversion
- Centralized parsing functions are testable
- Error messages should show the problematic value
- Edge case testing prevents future bugs

### Debugging Process Validation

This example perfectly demonstrates the 6-step methodology:
1. ✓ Reproduced with minimal data
2. ✓ Isolated to exact line
3. ✓ Formed hypothesis about comma handling
4. ✓ Tested with comprehensive cases
5. ✓ Fixed with minimal change
6. ✓ Verified with edge cases and regression testing

**Result**: Robust fix in ~20 minutes vs. potentially hours of trial-and-error
