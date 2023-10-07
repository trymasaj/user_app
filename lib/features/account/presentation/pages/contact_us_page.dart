import '../../../../shared_widgets/stateless/title_text.dart';

import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateful/default_button.dart';

import '../../../../shared_widgets/text_fields/default_text_form_field.dart';
import '../../../../shared_widgets/text_fields/email_text_form_field.dart';
import '../../../../shared_widgets/text_fields/first_name_text_form_field.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../di/injector.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../data/models/contact_us_message_model.dart';
import '../blocs/contact_us_cubit/contact_us_cubit.dart';

class ContactUsPage extends StatefulWidget {
  static const routeName = '/ContactUsPage';
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _fullNameTextController;
  late final TextEditingController _emailTextController;
  late final TextEditingController _messageTextController;

  late final FocusNode _fullNameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _messageFocusNode;

  bool _isAutoValidating = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();

    _fullNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _messageTextController = TextEditingController();

    _fullNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _messageFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _fullNameTextController.dispose();
    _emailTextController.dispose();
    _messageTextController.dispose();

    _fullNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector().contactUsCubit,
      child: CustomAppPage(
        withBackground: true,
        child: Scaffold(
          appBar: AppBar(title: const TitleText(text: 'contact_us')),
          body: Column(
            children: [
              const Spacer(flex: 2),
              Expanded(
                flex: 10,
                child: BlocConsumer<ContactUsCubit, ContactUsState>(
                  listener: (context, state) {
                    if (state.isError)
                      showSnackBar(context, message: state.errorMessage);
                    if (state.isSuccess) _goBackWithSuccess(context);
                  },
                  builder: (context, state) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildMessageForm(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8.0),
              _buildSendMessageButton(),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _isAutoValidating
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          FirstNameTextFormField(
              currentController: _fullNameTextController,
              currentFocusNode: _fullNameFocusNode,
              nextFocusNode: _emailFocusNode),
          const SizedBox(height: 16.0),
          EmailTextFormField(
            currentController: _emailTextController,
            currentFocusNode: _emailFocusNode,
            nextFocusNode: _messageFocusNode,
          ),
          const SizedBox(height: 16.0),
          DefaultTextFormField(
            isRequired: true,
            currentFocusNode: _messageFocusNode,
            currentController: _messageTextController,
            hint: 'message'.tr(),
            contentPadding: const EdgeInsets.all(16.0),
            maxLines: 8,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }

  Widget _buildSendMessageButton() {
    return Builder(builder: (context) {
      final contactUsCubit = context.read<ContactUsCubit>();
      return DefaultButton(
        label: 'send_message'.tr(),
        backgroundColor: AppColors.PRIMARY_COLOR,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        isExpanded: true,
        onPressed: () async {
          if (_isNotValid()) return;

          await contactUsCubit.sendContactUsMessage(ContactUsMessage(
            name: _fullNameTextController.text,
            email: _emailTextController.text.trim(),
            message: _messageTextController.text,
          ));
        },
      );
    });
  }

  bool _isNotValid() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  void _goBackWithSuccess(BuildContext context) {
    NavigatorHelper.of(context).pop(true);
  }
}
