enum MessageType {
  text('text'),
  image('image'),
  video('video'),
  audio('audio'),
  gif('gif');

  final String type;
  const MessageType(this.type);
}

extension CovertMessage on String {
  MessageType toMessageType() {
    return MessageType.values.firstWhere((e) => e.type == this);
  }
}
