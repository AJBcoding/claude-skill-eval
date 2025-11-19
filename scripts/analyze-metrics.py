#!/usr/bin/env python3
"""
Phase 2 Metrics Analysis Script
Created: 2025-11-19
Purpose: Analyze agent effectiveness metrics and generate reports
"""

import json
import sys
from pathlib import Path
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional
from collections import defaultdict, Counter
from dataclasses import dataclass
import statistics


@dataclass
class MetricResult:
    """Container for calculated metric results"""
    name: str
    value: float
    target: float
    unit: str
    status: str  # "above_target", "below_target", "on_target"
    trend: Optional[str] = None  # "improving", "declining", "stable"
    data_points: int = 0


class MetricsAnalyzer:
    """Analyze Phase 2 metrics from JSONL data"""

    def __init__(self, data_path: str):
        self.data_path = Path(data_path)
        self.events: List[Dict[str, Any]] = []
        self.load_events()

    def load_events(self):
        """Load events from JSONL file"""
        if not self.data_path.exists():
            print(f"Warning: Metrics file not found at {self.data_path}")
            print("No data to analyze yet. Metrics will be collected as agents run.")
            return

        with open(self.data_path, 'r') as f:
            for line in f:
                if line.strip():
                    try:
                        self.events.append(json.loads(line))
                    except json.JSONDecodeError as e:
                        print(f"Warning: Skipping malformed JSON line: {e}")

    def filter_events(
        self,
        metric_name: Optional[str] = None,
        agent_name: Optional[str] = None,
        start_date: Optional[datetime] = None,
        end_date: Optional[datetime] = None
    ) -> List[Dict[str, Any]]:
        """Filter events by various criteria"""
        filtered = self.events

        if metric_name:
            filtered = [e for e in filtered if e.get('metric_name') == metric_name]

        if agent_name:
            filtered = [e for e in filtered if e.get('agent_name') == agent_name]

        if start_date:
            filtered = [
                e for e in filtered
                if datetime.fromisoformat(e['timestamp'].replace('Z', '+00:00')) >= start_date
            ]

        if end_date:
            filtered = [
                e for e in filtered
                if datetime.fromisoformat(e['timestamp'].replace('Z', '+00:00')) <= end_date
            ]

        return filtered

    def calculate_bug_catch_rate(self) -> MetricResult:
        """
        Calculate percentage of bugs caught before code execution
        Target: 90%
        """
        events = self.filter_events(metric_name='bug_catch_rate')

        if not events:
            return MetricResult(
                name="Bug Catch Rate",
                value=0.0,
                target=90.0,
                unit="%",
                status="no_data",
                data_points=0
            )

        total_bugs = 0
        bugs_caught_pre_execution = 0

        for event in events:
            data = event.get('data', {})
            total_bugs += data.get('total_bugs', 0)
            bugs_caught_pre_execution += data.get('bugs_caught_pre_execution', 0)

        if total_bugs == 0:
            rate = 0.0
        else:
            rate = (bugs_caught_pre_execution / total_bugs) * 100

        status = "above_target" if rate >= 90 else "below_target"

        return MetricResult(
            name="Bug Catch Rate",
            value=round(rate, 1),
            target=90.0,
            unit="%",
            status=status,
            data_points=len(events)
        )

    def calculate_pattern_adherence_rate(self) -> MetricResult:
        """
        Calculate percentage of similar tasks following established patterns
        Target: 90%
        """
        events = self.filter_events(metric_name='pattern_adherence_rate')

        if not events:
            return MetricResult(
                name="Pattern Adherence Rate",
                value=0.0,
                target=90.0,
                unit="%",
                status="no_data",
                data_points=0
            )

        tasks_with_pattern = 0
        tasks_following_pattern = 0

        for event in events:
            data = event.get('data', {})
            tasks_with_pattern += data.get('tasks_with_applicable_pattern', 0)
            tasks_following_pattern += data.get('tasks_following_pattern', 0)

        if tasks_with_pattern == 0:
            rate = 0.0
        else:
            rate = (tasks_following_pattern / tasks_with_pattern) * 100

        status = "above_target" if rate >= 90 else "below_target"

        return MetricResult(
            name="Pattern Adherence Rate",
            value=round(rate, 1),
            target=90.0,
            unit="%",
            status=status,
            data_points=len(events)
        )

    def calculate_redirection_reduction(self, baseline: int = 10) -> MetricResult:
        """
        Calculate reduction in Claude redirections needed
        Target: 50% reduction from baseline
        """
        events = self.filter_events(metric_name='redirection_frequency')

        if not events:
            return MetricResult(
                name="Redirection Reduction",
                value=0.0,
                target=50.0,
                unit="%",
                status="no_data",
                data_points=0
            )

        # Group by session and count redirections
        session_redirections = defaultdict(int)
        for event in events:
            session_id = event.get('session_id')
            session_redirections[session_id] += 1

        if not session_redirections:
            avg_redirections = 0
        else:
            avg_redirections = statistics.mean(session_redirections.values())

        # Calculate reduction percentage
        if baseline == 0:
            reduction = 0
        else:
            reduction = ((baseline - avg_redirections) / baseline) * 100

        status = "above_target" if reduction >= 50 else "below_target"

        return MetricResult(
            name="Redirection Reduction",
            value=round(reduction, 1),
            target=50.0,
            unit="% reduction",
            status=status,
            data_points=len(events)
        )

    def calculate_debug_methodology_adherence(self) -> MetricResult:
        """
        Calculate percentage of debug sessions completing all 6 steps
        Target: 95%
        """
        events = self.filter_events(metric_name='debug_methodology_adherence')

        if not events:
            return MetricResult(
                name="Debug Methodology Adherence",
                value=0.0,
                target=95.0,
                unit="%",
                status="no_data",
                data_points=0
            )

        total_sessions = 0
        complete_sessions = 0
        required_steps = {'reproduce', 'isolate', 'hypothesis', 'test', 'fix', 'verify'}

        for event in events:
            data = event.get('data', {})
            total_sessions += 1
            steps_completed = set(data.get('steps_completed', []))

            if required_steps.issubset(steps_completed):
                complete_sessions += 1

        if total_sessions == 0:
            rate = 0.0
        else:
            rate = (complete_sessions / total_sessions) * 100

        status = "above_target" if rate >= 95 else "below_target"

        return MetricResult(
            name="Debug Methodology Adherence",
            value=round(rate, 1),
            target=95.0,
            unit="%",
            status=status,
            data_points=len(events)
        )

    def calculate_skill_activation_rate(self) -> MetricResult:
        """
        Calculate percentage of appropriate skill activations
        Target: 85%
        """
        events = self.filter_events(metric_name='skill_activation_rate')

        if not events:
            return MetricResult(
                name="Skill Activation Rate",
                value=0.0,
                target=85.0,
                unit="%",
                status="no_data",
                data_points=0
            )

        appropriate = 0
        missed = 0

        for event in events:
            data = event.get('data', {})
            appropriate += data.get('appropriate_activations', 0)
            missed += data.get('missed_activations', 0)

        total = appropriate + missed
        if total == 0:
            rate = 0.0
        else:
            rate = (appropriate / total) * 100

        status = "above_target" if rate >= 85 else "below_target"

        return MetricResult(
            name="Skill Activation Rate",
            value=round(rate, 1),
            target=85.0,
            unit="%",
            status=status,
            data_points=len(events)
        )

    def analyze_agent_performance(self) -> Dict[str, Dict[str, Any]]:
        """Analyze performance metrics for each agent"""
        events = self.filter_events(metric_name='agent_performance')

        agent_stats = defaultdict(lambda: {
            'activations': 0,
            'total_duration': 0,
            'total_tokens': 0,
            'successes': 0,
            'failures': 0,
            'trigger_types': Counter()
        })

        for event in events:
            agent = event.get('agent_name')
            data = event.get('data', {})

            stats = agent_stats[agent]
            stats['activations'] += 1
            stats['total_duration'] += data.get('duration', 0)
            stats['total_tokens'] += data.get('tokens_used', 0)

            if data.get('success'):
                stats['successes'] += 1
            else:
                stats['failures'] += 1

            trigger = data.get('trigger_type', 'unknown')
            stats['trigger_types'][trigger] += 1

        # Calculate averages
        result = {}
        for agent, stats in agent_stats.items():
            activations = stats['activations']
            result[agent] = {
                'total_activations': activations,
                'avg_duration': round(stats['total_duration'] / activations, 2) if activations else 0,
                'avg_tokens': round(stats['total_tokens'] / activations, 2) if activations else 0,
                'success_rate': round((stats['successes'] / activations) * 100, 1) if activations else 0,
                'trigger_breakdown': dict(stats['trigger_types'])
            }

        return result

    def analyze_quality_issues(self) -> Dict[str, Any]:
        """Analyze issues found by quality agent"""
        events = self.filter_events(metric_name='quality_gate_effectiveness')

        issue_stats = {
            'total_issues': 0,
            'by_severity': Counter(),
            'by_category': Counter(),
            'resolved': 0,
            'avg_quality_score': 0
        }

        quality_scores = []

        for event in events:
            data = event.get('data', {})
            issue_stats['total_issues'] += data.get('issues_found', 0)
            issue_stats['resolved'] += data.get('issues_resolved', 0)

            severity = data.get('issue_severity')
            if severity:
                issue_stats['by_severity'][severity] += 1

            category = data.get('issue_category')
            if category:
                issue_stats['by_category'][category] += 1

            score = data.get('quality_score')
            if score is not None:
                quality_scores.append(score)

        if quality_scores:
            issue_stats['avg_quality_score'] = round(statistics.mean(quality_scores), 1)

        issue_stats['by_severity'] = dict(issue_stats['by_severity'])
        issue_stats['by_category'] = dict(issue_stats['by_category'])

        return issue_stats

    def calculate_trend(self, metric_name: str, window_days: int = 7) -> Optional[str]:
        """Calculate trend for a metric over time window"""
        end_date = datetime.now()
        start_date = end_date - timedelta(days=window_days)

        events = self.filter_events(
            metric_name=metric_name,
            start_date=start_date,
            end_date=end_date
        )

        if len(events) < 2:
            return None

        # Sort by timestamp
        events.sort(key=lambda e: e['timestamp'])

        # Split into first half and second half
        mid = len(events) // 2
        first_half = events[:mid]
        second_half = events[mid:]

        # Calculate average value for each half (simplified)
        # In practice, would use the actual metric calculation
        def avg_value(event_list):
            values = [e.get('data', {}).get('value', 0) for e in event_list]
            return statistics.mean(values) if values else 0

        first_avg = avg_value(first_half)
        second_avg = avg_value(second_half)

        if second_avg > first_avg * 1.05:  # 5% improvement
            return "improving"
        elif second_avg < first_avg * 0.95:  # 5% decline
            return "declining"
        else:
            return "stable"

    def generate_summary_report(self) -> str:
        """Generate comprehensive summary report"""
        lines = []
        lines.append("=" * 80)
        lines.append("PHASE 2 METRICS ANALYSIS REPORT")
        lines.append(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        lines.append(f"Total Events: {len(self.events)}")
        lines.append("=" * 80)
        lines.append("")

        # Calculate all primary metrics
        lines.append("PRIMARY SUCCESS METRICS")
        lines.append("-" * 80)

        metrics = [
            self.calculate_bug_catch_rate(),
            self.calculate_pattern_adherence_rate(),
            self.calculate_redirection_reduction(),
            self.calculate_debug_methodology_adherence(),
            self.calculate_skill_activation_rate()
        ]

        for metric in metrics:
            status_symbol = "✓" if metric.status == "above_target" else "✗" if metric.status == "below_target" else "○"
            lines.append(f"{status_symbol} {metric.name}: {metric.value}{metric.unit} (Target: {metric.target}{metric.unit})")
            lines.append(f"  Data points: {metric.data_points}")
            if metric.trend:
                lines.append(f"  Trend: {metric.trend}")
            lines.append("")

        # Agent performance
        lines.append("AGENT PERFORMANCE")
        lines.append("-" * 80)
        agent_perf = self.analyze_agent_performance()
        for agent, stats in agent_perf.items():
            lines.append(f"{agent}:")
            lines.append(f"  Activations: {stats['total_activations']}")
            lines.append(f"  Avg Duration: {stats['avg_duration']}s")
            lines.append(f"  Avg Tokens: {stats['avg_tokens']}")
            lines.append(f"  Success Rate: {stats['success_rate']}%")
            lines.append(f"  Triggers: {stats['trigger_breakdown']}")
            lines.append("")

        # Quality issues
        lines.append("QUALITY GATE ANALYSIS")
        lines.append("-" * 80)
        quality = self.analyze_quality_issues()
        lines.append(f"Total Issues Found: {quality['total_issues']}")
        lines.append(f"Issues Resolved: {quality['resolved']}")
        lines.append(f"Average Quality Score: {quality['avg_quality_score']}/100")
        lines.append(f"By Severity: {quality['by_severity']}")
        lines.append(f"By Category: {quality['by_category']}")
        lines.append("")

        lines.append("=" * 80)

        return "\n".join(lines)

    def generate_dashboard_data(self) -> Dict[str, Any]:
        """Generate data for dashboard display"""
        return {
            'timestamp': datetime.now().isoformat(),
            'summary': {
                'total_events': len(self.events),
                'date_range': self._get_date_range()
            },
            'metrics': {
                'bug_catch_rate': self.calculate_bug_catch_rate().__dict__,
                'pattern_adherence': self.calculate_pattern_adherence_rate().__dict__,
                'redirection_reduction': self.calculate_redirection_reduction().__dict__,
                'debug_methodology': self.calculate_debug_methodology_adherence().__dict__,
                'skill_activation': self.calculate_skill_activation_rate().__dict__
            },
            'agents': self.analyze_agent_performance(),
            'quality': self.analyze_quality_issues()
        }

    def _get_date_range(self) -> Dict[str, str]:
        """Get date range of collected data"""
        if not self.events:
            return {'start': 'N/A', 'end': 'N/A'}

        timestamps = [e['timestamp'] for e in self.events]
        return {
            'start': min(timestamps),
            'end': max(timestamps)
        }


def main():
    """Main entry point"""
    # Determine data path
    script_dir = Path(__file__).parent
    repo_root = script_dir.parent
    data_path = repo_root / ".claude" / "data" / "metrics.jsonl"

    # Create analyzer
    analyzer = MetricsAnalyzer(str(data_path))

    # Generate and print report
    print(analyzer.generate_summary_report())
    print()

    # Optionally save dashboard data as JSON
    dashboard_data = analyzer.generate_dashboard_data()
    output_path = repo_root / "analysis" / "metrics" / "latest.json"
    output_path.parent.mkdir(parents=True, exist_ok=True)

    with open(output_path, 'w') as f:
        json.dump(dashboard_data, f, indent=2)

    print(f"Dashboard data saved to: {output_path}")


if __name__ == "__main__":
    main()
