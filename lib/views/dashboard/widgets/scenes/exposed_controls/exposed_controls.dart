import 'package:flutter/widgets.dart';
import 'package:obs_blade/views/dashboard/widgets/scenes/exposed_controls/replay_buffer_controls.dart';

import '../../../../../shared/general/hive_builder.dart';
import '../../../../../types/enums/hive_keys.dart';
import '../../../../../types/enums/settings_keys.dart';
import 'profile_control.dart';
import 'scene_collection_control.dart';
import 'recording_controls.dart';
import 'streaming_controls.dart';

class ExposedControls extends StatelessWidget {
  const ExposedControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HiveBuilder<dynamic>(
      hiveKey: HiveKeys.Settings,
      rebuildKeys: const [
        SettingsKeys.ExposeRecordingControls,
        SettingsKeys.ExposeStreamingControls,
        SettingsKeys.ExposeReplayBufferControls,
        SettingsKeys.ExposeSceneCollection,
        SettingsKeys.ExposeProfile,
      ],
      builder: (context, settingsBox, child) {
        List<Widget> exposedControls = [];

        if (settingsBox.get(SettingsKeys.ExposeProfile.name,
                defaultValue: true) ||
            settingsBox.get(SettingsKeys.ExposeSceneCollection.name,
                defaultValue: true)) {
          exposedControls.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0) +
                  const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  if (settingsBox.get(SettingsKeys.ExposeProfile.name,
                      defaultValue: true))
                    const Expanded(
                      child: ProfileControl(),
                    ),
                  const SizedBox(width: 24.0),
                  if (settingsBox.get(SettingsKeys.ExposeSceneCollection.name,
                      defaultValue: true))
                    const Expanded(
                      child: SceneCollectionControl(),
                    ),
                ],
              ),
            ),
          );
        }

        if (settingsBox.get(SettingsKeys.ExposeStreamingControls.name,
            defaultValue: false)) {
          exposedControls.add(const StreamingControls());
        }

        if (settingsBox.get(SettingsKeys.ExposeRecordingControls.name,
            defaultValue: false)) {
          exposedControls.add(const RecordingControls());
        }

        if (settingsBox.get(SettingsKeys.ExposeReplayBufferControls.name,
            defaultValue: false)) {
          exposedControls.add(const ReplayBufferControls());
        }

        exposedControls = List.from(exposedControls
            .expand((control) => [control, const SizedBox(height: 12.0)]));

        if (exposedControls.isNotEmpty) {
          exposedControls.insert(0, const SizedBox(height: 24.0));
          exposedControls.removeLast();
        }

        return Column(
          children: exposedControls,
        );
      },
    );
  }
}
