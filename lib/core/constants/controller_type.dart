enum ControllerType {
  delivery('_DEL', 'Delivery'),
  tower('_TWR', 'Tower'),
  ground('_GND', 'Ground'),
  approach('_APP', 'Approach'),
  departure('_DEP', 'Departure'),
  center('_CTR', 'Center'),
  service('_FSS', 'Flight Service'),
  observer('_OBS', 'Observer');

  final String code;
  final String label;

  const ControllerType(this.code, this.label);
}