import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../view_models/player_view_model.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(
      builder: (context, viewModel, child) {
        final position = viewModel.position.inMilliseconds.toDouble();
        final duration = viewModel.duration.inMilliseconds.toDouble();
        final value = position > 0.0 ? (position / duration).clamp(0.0, 1.0) : 0.0;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoSlider(
              value: value,
              onChanged: (value) {
                final newPosition = Duration(
                  milliseconds: (value * duration).toInt(),
                );
                viewModel.seekTo(newPosition);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(CupertinoIcons.backward_fill),
                  onPressed: viewModel.previous,
                  color: AppColors.text,
                ),
                IconButton(
                  icon: Icon(
                    viewModel.isPlaying 
                      ? CupertinoIcons.pause_fill 
                      : CupertinoIcons.play_fill
                  ),
                  onPressed: viewModel.togglePlay,
                  color: AppColors.text,
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.forward_fill),
                  onPressed: viewModel.next,
                  color: AppColors.text,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
} 