enum NafazStatusEnum {
  waiting('WAITING'),
  completed('COMPLETED'),
  expired('EXPIRED');
  final String type;
  const NafazStatusEnum(this.type);
  factory NafazStatusEnum.fromString(String type) {
    return values.firstWhere((e) => e.type == type);
  }
}
