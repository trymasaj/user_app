import 'package:flutter/material.dart';
import 'package:masaj/core/application/states/app_state.dart';

class Retry extends StatelessWidget {
  const Retry({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onTap,
        child: const Text('Retry'),
      ),
    );
  }
}

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Empty'),
    );
  }
}

class LoadStateHandler<T extends Object> extends StatelessWidget {
  const LoadStateHandler({
    super.key,
    required this.onTapRetry,
    this.empty,
    required this.customState,
    required this.onData,
  });

  final VoidCallback onTapRetry;
  final DataLoadState<T> customState;
  final Widget? empty;
  final Widget Function(T data) onData;

  @override
  Widget build(BuildContext context) {
    return switch (customState) {
      DataLoadLoadedState(data: final T data) => onData(data),
      DataLoadErrorState() => Retry(onTap: onTapRetry),
      DataLoadLoadingState() =>  const Progress(),
      _ => const SizedBox.shrink()
    };
  }
}
