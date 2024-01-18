import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';

class UserImageSelection extends StatefulWidget {
  const UserImageSelection({
    required this.isMale,
    super.key,
  });

  final bool isMale;

  @override
  State<UserImageSelection> createState() => _UserImageSelectionState();
}

class _UserImageSelectionState extends State<UserImageSelection> {
  late bool _isMale;
  bool showChoices = false;
  @override
  void initState() {
    _isMale = widget.isMale;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!showChoices) {
      return _buildImage();
    } else {
      return _buildGenderChoices(context);
    }
  }

  Widget _buildImage() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 12.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 44.0,
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: AssetImage(_isMale
                  ? 'assets/images/profile_male.webp'
                  : 'assets/images/profile_female.webp'),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: InkWell(
            child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  color: AppColors.PRIMARY_COLOR,
                ),
                child: const Icon(Icons.camera_alt)),
            onTap: () {
              setState(() {
                showChoices = !showChoices;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _buildGenderChoices(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 44.0,
            child: CircleAvatar(
                radius: 40.0,
                backgroundImage:
                    AssetImage('assets/images/profile_male.webp')),
          ),
          onTap: () {
            authCubit.selectGender(Gender.male);
            setState(() {
              showChoices = !showChoices;
            });
          },
        ),
        const TitleText(
          text: 'or',
          margin: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        InkWell(
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 44.0,
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: AssetImage('assets/images/profile_female.webp'),
            ),
          ),
          onTap: () {
            authCubit.selectGender(Gender.female);
            setState(() {
              showChoices = !showChoices;
            });
          },
        ),
      ],
    );
  }
}
