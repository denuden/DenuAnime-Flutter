class BaseImagesModel {
  final String? image_url;
  final String? small_image_url;
  final String? medium_image_url;
  final String? large_image_url;
  final String? maximum_image_url;

  const BaseImagesModel({
    this.image_url,
    this.small_image_url,
    this.medium_image_url,
    this.large_image_url,
    this.maximum_image_url,
  });

  factory BaseImagesModel.fromJson(Map<String, dynamic> json) {
    return BaseImagesModel(
      image_url: json['image_url'] as String?,
      small_image_url: json['small_image_url'] as String?,
      medium_image_url: json['medium_image_url'] as String?,
      large_image_url: json['large_image_url'] as String?,
      maximum_image_url: json['maximum_image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_url': image_url,
      'small_image_url': small_image_url,
      'medium_image_url': medium_image_url,
      'large_image_url': large_image_url,
      'maximum_image_url': maximum_image_url,
    };
  }
}
