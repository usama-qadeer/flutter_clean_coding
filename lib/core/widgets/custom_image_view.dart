import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      if (endsWith('.svg')) {
        return ImageType.networkSvg;
      }
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      return ImageType.file;
    } else if (startsWith('/data/user')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, networkSvg, png, network, file, unknown }

class CustomImageView extends StatelessWidget {
  const CustomImageView({
    this.fit,
    super.key,
    this.width,
    this.color,
    this.onTap,
    this.height,
    this.radius,
    this.margin,
    this.border,
    this.imagePath,
    this.alignment,
    this.placeHolder = 'assets/images/no_image.jpg',
  });

  ///[imagePath] is required parameter for showing image
  final BoxFit? fit;
  final Color? color;
  final double? width;
  final double? height;
  final String? imagePath;
  final BoxBorder? border;
  final String placeHolder;
  final VoidCallback? onTap;
  final Alignment? alignment;
  final BorderRadius? radius;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget())
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(onTap: onTap, child: _buildCircleImage()),
    );
  }

  ///build the image with border radius
  dynamic _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  Widget _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(border: border, borderRadius: radius),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (imagePath != null) {
      switch (imagePath!.imageType) {
        case ImageType.svg:
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imagePath!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null
                  ? ColorFilter.mode(
                      color ?? Colors.transparent,
                      BlendMode.srcIn,
                    )
                  : null,
            ),
          );
        case ImageType.networkSvg:
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.network(
              imagePath!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null
                  ? ColorFilter.mode(
                      color ?? Colors.transparent,
                      BlendMode.srcIn,
                    )
                  : null,
            ),
          );
        case ImageType.file:
          return Image.file(
            width: width,
            color: color,
            height: height,
            File(imagePath!),
            fit: fit ?? BoxFit.cover,
          );
        case ImageType.network:
          return CachedNetworkImage(
            height: height,
            width: width,
            fit: fit,
            imageUrl: imagePath!,
            color: color,
            placeholder: (context, url) => SizedBox(
              height: 30,
              width: 30,
              child: LinearProgressIndicator(
                color: Colors.grey.shade200,
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              placeHolder,
              height: height,
              width: width,
              fit: fit ?? BoxFit.cover,
            ),
          );
        case ImageType.png:
        default:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
      }
    }
    return const SizedBox();
  }
}
