
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'temperature_controller.dart';

class TemperatureView extends StatefulWidget {
  const TemperatureView({super.key});

  @override
  State<TemperatureView> createState() => _TemperatureViewState();
}

class _TemperatureViewState extends State<TemperatureView> {
  final TextEditingController _inputController =
  TextEditingController();

  static const Color primaryColor = Color(0xFF536DFE);
  static const Color darkColor = Color(0xFF172554);
  static const Color mutedColor = Color(0xFF8490A8);

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _convert() {
    FocusScope.of(context).unfocus();

    context.read<TemperatureController>().convert(
      _inputController.text,
    );
  }

  void _clear() {
    _inputController.clear();
    context.read<TemperatureController>().clear();
  }

  void _selectPreset(String value) {
    _inputController.text = value;
    context.read<TemperatureController>().clear();
  }

  Future<void> _copyResult(String result) async {
    await Clipboard.setData(
      ClipboardData(text: result),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Result copied successfully!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TemperatureController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FC),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 82,
        titleSpacing: 22,

        title: Row(
          children: [
            // App Logo
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF536DFE),
                    Color(0xFF7B8CFF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF536DFE).withOpacity(0.22),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.thermostat_rounded,
                color: Colors.white,
                size: 27,
              ),
            ),

            const SizedBox(width: 12),

            // App Name
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Thermos',
                  style: TextStyle(
                    color: Color(0xFF172554),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.7,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'TEMPERATURE CONVERTER',
                  style: TextStyle(
                    color: Color(0xFF8490A8),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: IconButton(
                onPressed: () {
                  context.read<TemperatureController>().clear();

                  // Clear input field
                  _inputController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Converter has been reset!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                tooltip: 'Reset Converter',
                icon: const Icon(
                  Icons.restart_alt_rounded,
                  color: Color(0xFF536DFE),
                  size: 27,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFE8ECFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const Text(
                    'Temperature',
                    style: TextStyle(
                      color: darkColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),

                  const Text(
                    'Convert temperatures with ease.',
                    style: TextStyle(
                      color: mutedColor,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 26),

                  // Main Converter Card
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF263B70)
                              .withOpacity(0.07),
                          blurRadius: 28,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ENTER TEMPERATURE',
                          style: TextStyle(
                            color: mutedColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Temperature Input
                        TextField(
                          controller: _inputController,
                          keyboardType:
                          const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          style: const TextStyle(
                            color: darkColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter value',
                            hintStyle: const TextStyle(
                              color: Color(0xFFBBC3D2),
                              fontSize: 20,
                            ),
                            suffixText: controller.fromUnit.symbol,
                            suffixStyle: const TextStyle(
                              color: primaryColor,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF6F7FB),
                            contentPadding:
                            const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 19,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (_) {
                            controller.clear();
                          },
                          onSubmitted: (_) => _convert(),
                        ),

                        const SizedBox(height: 24),

                        // Unit Selection
                        Row(
                          children: [
                            Expanded(
                              child: _unitSelector(
                                title: 'FROM',
                                unit: controller.fromUnit,
                                onChanged: (unit) {
                                  controller.changeUnit(unit);
                                },
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Swap Button
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: InkWell(
                                onTap: controller.swapUnits,
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8ECFF),
                                    borderRadius:
                                    BorderRadius.circular(14),
                                  ),
                                  child: const Icon(
                                    Icons.swap_horiz_rounded,
                                    color: primaryColor,
                                    size: 27,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: _unitSelector(
                                title: 'TO',
                                unit: controller.toUnit,
                                enabled: false,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // Convert Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _convert,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.sync_rounded,
                                  size: 21,
                                ),
                                SizedBox(width: 9),
                                Text(
                                  'Convert Temperature',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Result Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(23),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF536DFE),
                          Color(0xFF304FFE),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.22),
                          blurRadius: 20,
                          offset: const Offset(0, 9),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'CONVERSION RESULT',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),

                            if (controller.hasResult)
                              IconButton(
                                onPressed: () {
                                  _copyResult(
                                    controller.result!.formattedValue,
                                  );
                                },
                                icon: const Icon(
                                  Icons.copy_rounded,
                                  color: Colors.white,
                                  size: 19,
                                ),
                                tooltip: 'Copy result',
                              ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        if (controller.errorMessage != null)
                          Text(
                            controller.errorMessage!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        else if (controller.result != null)
                          Text(
                            controller.result!.formattedValue,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1,
                            ),
                          )
                        else
                          const Text(
                            'Your result will appear here',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                        const SizedBox(height: 8),

                        Text(
                          '${controller.fromUnit.symbol}  →  ${controller.toUnit.symbol}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 26),

                  // Quick Presets
                  const Text(
                    'Quick temperatures',
                    style: TextStyle(
                      color: darkColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 13),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _presetChip('0'),
                      _presetChip('32'),
                      _presetChip('100'),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Formula Information
                  Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF2FF),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.lightbulb_outline_rounded,
                          color: primaryColor,
                          size: 23,
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Conversion formula',
                                style: TextStyle(
                                  color: darkColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                controller.fromUnit ==
                                    TemperatureUnit.celsius
                                    ? '°F = (°C × 9/5) + 32'
                                    : '°C = (°F − 32) × 5/9',
                                style: const TextStyle(
                                  color: Color(0xFF596780),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Clear Button
                  Center(
                    child: TextButton.icon(
                      onPressed: _clear,
                      icon: const Icon(
                        Icons.refresh_rounded,
                        size: 18,
                      ),
                      label: const Text('Clear all'),
                      style: TextButton.styleFrom(
                        foregroundColor: mutedColor,
                      ),
                    ),
                  ),




                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Unit Selector Widget
  Widget _unitSelector({
    required String title,
    required TemperatureUnit unit,
    ValueChanged<TemperatureUnit>? onChanged,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: mutedColor,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F7FB),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: const Color(0xFFE8EBF2),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<TemperatureUnit>(
              value: unit,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: mutedColor,
              ),
              items: TemperatureUnit.values.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item.label,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: darkColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
              onChanged: enabled
                  ? (value) {
                if (value != null) {
                  onChanged?.call(value);
                }
              }
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  // Quick Preset Chip
  Widget _presetChip(String value) {
    return InkWell(
      onTap: () => _selectPreset(value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE5E9F2),
          ),
        ),
        child: Text(
          value,
          style: const TextStyle(
            color: darkColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
