enum ProjectStatus {
  inProgress(label: 'Em andamento'),
  finished(label: 'Finalizado');

  const ProjectStatus({
    required this.label,
  });

  final String label;
}
