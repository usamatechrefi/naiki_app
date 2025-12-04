// import 'dart:async';
// import 'dart:io';
// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:record/record.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/dimensions.dart';
// import '../../../../core/constants/text_styles.dart';
//
// class VoiceRecorderComponent extends StatefulWidget {
//   final Function(String path) onRecordingComplete;
//   final VoidCallback onDelete;
//   final String? existingVoicePath;
//
//   const VoiceRecorderComponent({
//     Key? key,
//     required this.onRecordingComplete,
//     required this.onDelete,
//     this.existingVoicePath,
//   }) : super(key: key);
//
//   @override
//   State<VoiceRecorderComponent> createState() => _VoiceRecorderComponentState();
// }
//
// class _VoiceRecorderComponentState extends State<VoiceRecorderComponent> with TickerProviderStateMixin {
//   late final AudioRecorder _audioRecorder;
//   late final AudioPlayer _audioPlayer;
//
//   bool _isRecording = false;
//   bool _isPlaying = false;
//
//   Duration _recordDuration = Duration.zero;
//   Duration _totalDuration = Duration.zero;
//   Duration _playbackPosition = Duration.zero;
//
//   Timer? _timer;
//
//   // For wave animation
//   late AnimationController _waveController;
//   StreamSubscription? _playerCompleteSubscription;
//   StreamSubscription? _playerPositionSubscription;
//   StreamSubscription? _playerDurationSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _audioRecorder = AudioRecorder();
//     _audioPlayer = AudioPlayer();
//
//     _waveController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     )..repeat();
//
//     _setupAudioPlayerListeners();
//
//     // If there is an existing file, try to get its duration
//     if (widget.existingVoicePath != null) {
//       _initializeExistingFile(widget.existingVoicePath!);
//     }
//   }
//
//   @override
//   void didUpdateWidget(VoiceRecorderComponent oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.existingVoicePath != oldWidget.existingVoicePath) {
//       if (widget.existingVoicePath == null) {
//         _resetState();
//       } else {
//         _initializeExistingFile(widget.existingVoicePath!);
//       }
//     }
//   }
//
//   void _setupAudioPlayerListeners() {
//     _playerCompleteSubscription = _audioPlayer.onPlayerComplete.listen((event) {
//       setState(() {
//         _isPlaying = false;
//         _playbackPosition = Duration.zero;
//       });
//     });
//
//     _playerPositionSubscription = _audioPlayer.onPositionChanged.listen((position) {
//       setState(() {
//         _playbackPosition = position;
//       });
//     });
//
//     _playerDurationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
//       setState(() {
//         _totalDuration = duration;
//       });
//     });
//   }
//
//   Future<void> _initializeExistingFile(String path) async {
//     try {
//       await _audioPlayer.setSource(DeviceFileSource(path));
//       final duration = await _audioPlayer.getDuration();
//       if (duration != null) {
//         setState(() {
//           _totalDuration = duration;
//         });
//       }
//     } catch (e) {
//       debugPrint('Error initializing audio file: $e');
//     }
//   }
//
//   void _resetState() {
//     _audioPlayer.stop();
//     setState(() {
//       _recordDuration = Duration.zero;
//       _totalDuration = Duration.zero;
//       _playbackPosition = Duration.zero;
//       _isPlaying = false;
//       _isRecording = false;
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _waveController.dispose();
//     _audioRecorder.dispose();
//     _audioPlayer.dispose();
//     _playerCompleteSubscription?.cancel();
//     _playerPositionSubscription?.cancel();
//     _playerDurationSubscription?.cancel();
//     super.dispose();
//   }
//
//   Future<void> _startRecording() async {
//     try {
//       if (await _audioRecorder.hasPermission()) {
//         final directory = await getApplicationDocumentsDirectory();
//         final path = '${directory.path}/voice_message_${DateTime.now().millisecondsSinceEpoch}.m4a';
//
//         await _audioRecorder.start(const RecordConfig(), path: path);
//
//         setState(() {
//           _isRecording = true;
//           _recordDuration = Duration.zero;
//         });
//
//         _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//           setState(() {
//             _recordDuration = Duration(seconds: timer.tick);
//           });
//         });
//       } else {
//         _showPermissionError();
//       }
//     } catch (e) {
//       debugPrint('Error starting recording: $e');
//     }
//   }
//
//   Future<void> _stopRecording() async {
//     try {
//       final path = await _audioRecorder.stop();
//       _timer?.cancel();
//
//       setState(() {
//         _isRecording = false;
//         _totalDuration = _recordDuration; // Set total duration from recording time
//       });
//
//       if (path != null) {
//         widget.onRecordingComplete(path);
//         // Prepare player for the new file
//         await _audioPlayer.setSource(DeviceFileSource(path));
//       }
//     } catch (e) {
//       debugPrint('Error stopping recording: $e');
//     }
//   }
//
//   Future<void> _deleteRecording() async {
//     await _audioPlayer.stop();
//     widget.onDelete();
//     // State reset will be handled by didUpdateWidget when existingVoicePath becomes null
//     // But we can also reset locally to be snappy
//     _resetState();
//   }
//
//   Future<void> _togglePlay() async {
//     if (_isPlaying) {
//       await _audioPlayer.pause();
//       setState(() => _isPlaying = false);
//     } else {
//       if (widget.existingVoicePath != null) {
//         await _audioPlayer.play(DeviceFileSource(widget.existingVoicePath!));
//         setState(() => _isPlaying = true);
//       }
//     }
//   }
//
//   Future<void> _seekTo(double value) async {
//     final position = Duration(milliseconds: (value * _totalDuration.inMilliseconds).toInt());
//     await _audioPlayer.seek(position);
//   }
//
//   void _showPermissionError() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Microphone permission is required to record voice messages.'),
//         backgroundColor: AppColors.error,
//       ),
//     );
//   }
//
//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$twoDigitMinutes:$twoDigitSeconds";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final hasRecording = widget.existingVoicePath != null;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(AppDimensions.paddingMD),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceVariant,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
//         border: Border.all(
//           color: hasRecording
//               ? AppColors.success.withOpacity(0.5)
//               : _isRecording
//                   ? AppColors.error.withOpacity(0.5)
//                   : AppColors.textTertiary.withOpacity(0.3),
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//            Text(
//             'Voice Message (Optional)',
//             style: AppTextStyles.labelLarge.copyWith(
//               color: AppColors.textPrimary,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: AppDimensions.marginMD),
//
//           if (_isRecording)
//             _buildRecordingState()
//           else if (hasRecording)
//             _buildPlaybackState()
//           else
//             _buildIdleState(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildIdleState() {
//     return InkWell(
//       onTap: _startRecording,
//       borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingMD),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: AppColors.surface,
//           borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//           border: Border.all(color: AppColors.textTertiary.withOpacity(0.2)),
//         ),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(AppDimensions.paddingMD),
//               decoration: BoxDecoration(
//                 color: AppColors.backgroundDarkLeaf.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.mic_rounded, color: AppColors.backgroundDarkLeaf, size: 32),
//             ),
//             const SizedBox(height: AppDimensions.marginSM),
//             Text(
//               'Tap to Record',
//               style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRecordingState() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           // Pulsing/Wave animation
//           Container(
//             padding: const EdgeInsets.all(AppDimensions.paddingSM),
//             decoration: BoxDecoration(
//               color: AppColors.error.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.mic, color: AppColors.error),
//           ),
//           const SizedBox(width: AppDimensions.marginMD),
//
//           // Timer
//           Text(
//             _formatDuration(_recordDuration),
//             style: AppTextStyles.titleMedium.copyWith(
//               color: AppColors.error,
//               fontFamily: 'Courier', // Monospace for timer
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//
//           const SizedBox(width: AppDimensions.marginMD),
//
//           // Waveform visualization (simulated)
//           Expanded(
//             child: SizedBox(
//               height: 30,
//               child: AnimatedBuilder(
//                 animation: _waveController,
//                 builder: (context, child) {
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: List.generate(15, (index) {
//                       // Create a wave effect
//                       final value = sin((_waveController.value * 2 * pi) + (index * 0.5));
//                       final height = 10 + (value.abs() * 15);
//                       return Container(
//                         width: 3,
//                         height: height,
//                         decoration: BoxDecoration(
//                           color: AppColors.error.withOpacity(0.6),
//                           borderRadius: BorderRadius.circular(1.5),
//                         ),
//                       );
//                     }),
//                   );
//                 },
//               ),
//             ),
//           ),
//
//           const SizedBox(width: AppDimensions.marginMD),
//
//           // Stop Button
//           IconButton(
//             onPressed: _stopRecording,
//             icon: const Icon(Icons.stop_circle_outlined, color: AppColors.error, size: 36),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPlaybackState() {
//     // Calculate progress
//     final totalMilliseconds = _totalDuration.inMilliseconds;
//     final currentMilliseconds = _playbackPosition.inMilliseconds;
//     final progress = totalMilliseconds > 0 ? (currentMilliseconds / totalMilliseconds).clamp(0.0, 1.0) : 0.0;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           IconButton(
//             onPressed: _togglePlay,
//             icon: Icon(
//               _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
//               color: AppColors.backgroundDarkLeaf,
//               size: 44,
//             ),
//           ),
//           const SizedBox(width: AppDimensions.marginSM),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SliderTheme(
//                   data: SliderTheme.of(context).copyWith(
//                     thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
//                     overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
//                     trackHeight: 4,
//                     activeTrackColor: AppColors.backgroundDarkLeaf,
//                     inactiveTrackColor: AppColors.textTertiary.withOpacity(0.2),
//                     thumbColor: AppColors.backgroundDarkLeaf,
//                   ),
//                   child: Slider(
//                     value: progress,
//                     onChanged: (v) {
//                       _seekTo(v);
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(_formatDuration(_playbackPosition), style: AppTextStyles.labelSmall),
//                       Text(_formatDuration(_totalDuration), style: AppTextStyles.labelSmall),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: _deleteRecording,
//             icon: const Icon(Icons.delete_outline, color: AppColors.textSecondary),
//           ),
//         ],
//       ),
//     );
//   }
// }
