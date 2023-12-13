import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toolbox/data/model/server/nvdia.dart';

const _raw = '''
<?xml version="1.0" ?>
<!DOCTYPE nvidia_smi_log SYSTEM "nvsmi_device_v12.dtd">
<nvidia_smi_log>
        <timestamp>Mon Nov 27 15:08:08 2023</timestamp>
        <driver_version>535.129.03</driver_version>
        <cuda_version>12.2</cuda_version>
        <attached_gpus>1</attached_gpus>
        <gpu id="00000000:01:00.0">
                <product_name>NVIDIA GeForce RTX 3080 Ti</product_name>
                <product_brand>GeForce</product_brand>
                <product_architecture>Ampere</product_architecture>
                <display_mode>Enabled</display_mode>
                <display_active>Enabled</display_active>
                <persistence_mode>Disabled</persistence_mode>
                <addressing_mode>None</addressing_mode>
                <mig_mode>
                        <current_mig>N/A</current_mig>
                        <pending_mig>N/A</pending_mig>
                </mig_mode>
                <mig_devices>
                        None
                </mig_devices>
                <accounting_mode>Disabled</accounting_mode>
                <accounting_mode_buffer_size>4000</accounting_mode_buffer_size>
                <driver_model>
                        <current_dm>N/A</current_dm>
                        <pending_dm>N/A</pending_dm>
                </driver_model>
                <serial>N/A</serial>
                <uuid>GPU-71dd2db7-1b83-c2f0-8c13-46b94790bafd</uuid>
                <minor_number>0</minor_number>
                <vbios_version>94.02.71.00.28</vbios_version>
                <multigpu_board>No</multigpu_board>
                <board_id>0x100</board_id>
                <board_part_number>N/A</board_part_number>
                <gpu_part_number>2208-225-A1</gpu_part_number>
                <gpu_fru_part_number>N/A</gpu_fru_part_number>
                <gpu_module_id>1</gpu_module_id>
                <inforom_version>
                        <img_version>G001.0000.03.03</img_version>
                        <oem_object>2.0</oem_object>
                        <ecc_object>N/A</ecc_object>
                        <pwr_object>N/A</pwr_object>
                </inforom_version>
                <inforom_bbx_flush>
                        <latest_timestamp>N/A</latest_timestamp>
                        <latest_duration>N/A</latest_duration>
                </inforom_bbx_flush>
                <gpu_operation_mode>
                        <current_gom>N/A</current_gom>
                        <pending_gom>N/A</pending_gom>
                </gpu_operation_mode>
                <gsp_firmware_version>N/A</gsp_firmware_version>
                <gpu_virtualization_mode>
                        <virtualization_mode>None</virtualization_mode>
                        <host_vgpu_mode>N/A</host_vgpu_mode>
                </gpu_virtualization_mode>
                <gpu_reset_status>
                        <reset_required>No</reset_required>
                        <drain_and_reset_recommended>N/A</drain_and_reset_recommended>
                </gpu_reset_status>
                <ibmnpu>
                        <relaxed_ordering_mode>N/A</relaxed_ordering_mode>
                </ibmnpu>
                <pci>
                        <pci_bus>01</pci_bus>
                        <pci_device>00</pci_device>
                        <pci_domain>0000</pci_domain>
                        <pci_device_id>220810DE</pci_device_id>
                        <pci_bus_id>00000000:01:00.0</pci_bus_id>
                        <pci_sub_system_id>15351B4C</pci_sub_system_id>
                        <pci_gpu_link_info>
                                <pcie_gen>
                                        <max_link_gen>4</max_link_gen>
                                        <current_link_gen>1</current_link_gen>
                                        <device_current_link_gen>1</device_current_link_gen>
                                        <max_device_link_gen>4</max_device_link_gen>
                                        <max_host_link_gen>5</max_host_link_gen>
                                </pcie_gen>
                                <link_widths>
                                        <max_link_width>16x</max_link_width>
                                        <current_link_width>16x</current_link_width>
                                </link_widths>
                        </pci_gpu_link_info>
                        <pci_bridge_chip>
                                <bridge_chip_type>N/A</bridge_chip_type>
                                <bridge_chip_fw>N/A</bridge_chip_fw>
                        </pci_bridge_chip>
                        <replay_counter>0</replay_counter>
                        <replay_rollover_counter>0</replay_rollover_counter>
                        <tx_util>0 KB/s</tx_util>
                        <rx_util>0 KB/s</rx_util>
                        <atomic_caps_inbound>N/A</atomic_caps_inbound>
                        <atomic_caps_outbound>N/A</atomic_caps_outbound>
                </pci>
                <fan_speed>0 %</fan_speed>
                <performance_state>P8</performance_state>
                <clocks_event_reasons>
                        <clocks_event_reason_gpu_idle>Active</clocks_event_reason_gpu_idle>
                        <clocks_event_reason_applications_clocks_setting>Not Active</clocks_event_reason_applications_clocks_setting>
                        <clocks_event_reason_sw_power_cap>Not Active</clocks_event_reason_sw_power_cap>
                        <clocks_event_reason_hw_slowdown>Not Active</clocks_event_reason_hw_slowdown>
                        <clocks_event_reason_hw_thermal_slowdown>Not Active</clocks_event_reason_hw_thermal_slowdown>
                        <clocks_event_reason_hw_power_brake_slowdown>Not Active</clocks_event_reason_hw_power_brake_slowdown>
                        <clocks_event_reason_sync_boost>Not Active</clocks_event_reason_sync_boost>
                        <clocks_event_reason_sw_thermal_slowdown>Not Active</clocks_event_reason_sw_thermal_slowdown>
                        <clocks_event_reason_display_clocks_setting>Not Active</clocks_event_reason_display_clocks_setting>
                </clocks_event_reasons>
                <fb_memory_usage>
                        <total>12288 MiB</total>
                        <reserved>245 MiB</reserved>
                        <used>352 MiB</used>
                        <free>11690 MiB</free>
                </fb_memory_usage>
                <bar1_memory_usage>
                        <total>256 MiB</total>
                        <used>7 MiB</used>
                        <free>249 MiB</free>
                </bar1_memory_usage>
                <cc_protected_memory_usage>
                        <total>0 MiB</total>
                        <used>0 MiB</used>
                        <free>0 MiB</free>
                </cc_protected_memory_usage>
                <compute_mode>Default</compute_mode>
                <utilization>
                        <gpu_util>3 %</gpu_util>
                        <memory_util>2 %</memory_util>
                        <encoder_util>0 %</encoder_util>
                        <decoder_util>0 %</decoder_util>
                        <jpeg_util>0 %</jpeg_util>
                        <ofa_util>0 %</ofa_util>
                </utilization>
                <encoder_stats>
                        <session_count>0</session_count>
                        <average_fps>0</average_fps>
                        <average_latency>0</average_latency>
                </encoder_stats>
                <fbc_stats>
                        <session_count>0</session_count>
                        <average_fps>0</average_fps>
                        <average_latency>0</average_latency>
                </fbc_stats>
                <ecc_mode>
                        <current_ecc>N/A</current_ecc>
                        <pending_ecc>N/A</pending_ecc>
                </ecc_mode>
                <ecc_errors>
                        <volatile>
                                <sram_correctable>N/A</sram_correctable>
                                <sram_uncorrectable>N/A</sram_uncorrectable>
                                <dram_correctable>N/A</dram_correctable>
                                <dram_uncorrectable>N/A</dram_uncorrectable>
                        </volatile>
                        <aggregate>
                                <sram_correctable>N/A</sram_correctable>
                                <sram_uncorrectable>N/A</sram_uncorrectable>
                                <dram_correctable>N/A</dram_correctable>
                                <dram_uncorrectable>N/A</dram_uncorrectable>
                        </aggregate>
                </ecc_errors>
                <retired_pages>
                        <multiple_single_bit_retirement>
                                <retired_count>N/A</retired_count>
                                <retired_pagelist>N/A</retired_pagelist>
                        </multiple_single_bit_retirement>
                        <double_bit_retirement>
                                <retired_count>N/A</retired_count>
                                <retired_pagelist>N/A</retired_pagelist>
                        </double_bit_retirement>
                        <pending_blacklist>N/A</pending_blacklist>
                        <pending_retirement>N/A</pending_retirement>
                </retired_pages>
                <remapped_rows>N/A</remapped_rows>
                <temperature>
                        <gpu_temp>34 C</gpu_temp>
                        <gpu_temp_tlimit>N/A</gpu_temp_tlimit>
                        <gpu_temp_max_threshold>98 C</gpu_temp_max_threshold>
                        <gpu_temp_slow_threshold>95 C</gpu_temp_slow_threshold>
                        <gpu_temp_max_gpu_threshold>93 C</gpu_temp_max_gpu_threshold>
                        <gpu_target_temperature>83 C</gpu_target_temperature>
                        <memory_temp>N/A</memory_temp>
                        <gpu_temp_max_mem_threshold>N/A</gpu_temp_max_mem_threshold>
                </temperature>
                <supported_gpu_target_temp>
                        <gpu_target_temp_min>65 C</gpu_target_temp_min>
                        <gpu_target_temp_max>91 C</gpu_target_temp_max>
                </supported_gpu_target_temp>
                <gpu_power_readings>
                        <power_state>P8</power_state>
                        <power_draw>24.55 W</power_draw>
                        <current_power_limit>350.00 W</current_power_limit>
                        <requested_power_limit>350.00 W</requested_power_limit>
                        <default_power_limit>350.00 W</default_power_limit>
                        <min_power_limit>100.00 W</min_power_limit>
                        <max_power_limit>380.00 W</max_power_limit>
                </gpu_power_readings>
                <module_power_readings>
                        <power_state>P8</power_state>
                        <power_draw>N/A</power_draw>
                        <current_power_limit>N/A</current_power_limit>
                        <requested_power_limit>N/A</requested_power_limit>
                        <default_power_limit>N/A</default_power_limit>
                        <min_power_limit>N/A</min_power_limit>
                        <max_power_limit>N/A</max_power_limit>
                </module_power_readings>
                <clocks>
                        <graphics_clock>210 MHz</graphics_clock>
                        <sm_clock>210 MHz</sm_clock>
                        <mem_clock>405 MHz</mem_clock>
                        <video_clock>555 MHz</video_clock>
                </clocks>
                <applications_clocks>
                        <graphics_clock>N/A</graphics_clock>
                        <mem_clock>N/A</mem_clock>
                </applications_clocks>
                <default_applications_clocks>
                        <graphics_clock>N/A</graphics_clock>
                        <mem_clock>N/A</mem_clock>
                </default_applications_clocks>
                <deferred_clocks>
                        <mem_clock>N/A</mem_clock>
                </deferred_clocks>
                <max_clocks>
                        <graphics_clock>2145 MHz</graphics_clock>
                        <sm_clock>2145 MHz</sm_clock>
                        <mem_clock>9501 MHz</mem_clock>
                        <video_clock>1950 MHz</video_clock>
                </max_clocks>
                <max_customer_boost_clocks>
                        <graphics_clock>N/A</graphics_clock>
                </max_customer_boost_clocks>
                <clock_policy>
                        <auto_boost>N/A</auto_boost>
                        <auto_boost_default>N/A</auto_boost_default>
                </clock_policy>
                <voltage>
                        <graphics_volt>775.000 mV</graphics_volt>
                </voltage>
                <fabric>
                        <state>N/A</state>
                        <status>N/A</status>
                </fabric>
                <supported_clocks>
                        <supported_mem_clock>
                                <value>9501 MHz</value>
                                <supported_graphics_clock>2145 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2130 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2115 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2100 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2085 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2070 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2055 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2040 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2025 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2010 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1995 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1980 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1965 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1950 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1935 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1920 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1905 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1890 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1875 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1860 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1845 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1830 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1815 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1800 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1785 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1770 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1755 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1740 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1725 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1710 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1695 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1680 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1665 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1650 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1635 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1620 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1605 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1590 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1575 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1560 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1545 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1530 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1515 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1500 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1485 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1470 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1455 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1440 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1425 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1410 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1395 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1380 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1365 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1350 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1335 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1320 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1305 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1290 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1275 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1260 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1245 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1230 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1215 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1200 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1185 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1170 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1155 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1140 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1125 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1110 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1095 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1080 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1065 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1050 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1035 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1020 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1005 MHz</supported_graphics_clock>
                                <supported_graphics_clock>990 MHz</supported_graphics_clock>
                                <supported_graphics_clock>975 MHz</supported_graphics_clock>
                                <supported_graphics_clock>960 MHz</supported_graphics_clock>
                                <supported_graphics_clock>945 MHz</supported_graphics_clock>
                                <supported_graphics_clock>930 MHz</supported_graphics_clock>
                                <supported_graphics_clock>915 MHz</supported_graphics_clock>
                                <supported_graphics_clock>900 MHz</supported_graphics_clock>
                                <supported_graphics_clock>885 MHz</supported_graphics_clock>
                                <supported_graphics_clock>870 MHz</supported_graphics_clock>
                                <supported_graphics_clock>855 MHz</supported_graphics_clock>
                                <supported_graphics_clock>840 MHz</supported_graphics_clock>
                                <supported_graphics_clock>825 MHz</supported_graphics_clock>
                                <supported_graphics_clock>810 MHz</supported_graphics_clock>
                                <supported_graphics_clock>795 MHz</supported_graphics_clock>
                                <supported_graphics_clock>780 MHz</supported_graphics_clock>
                                <supported_graphics_clock>765 MHz</supported_graphics_clock>
                                <supported_graphics_clock>750 MHz</supported_graphics_clock>
                                <supported_graphics_clock>735 MHz</supported_graphics_clock>
                                <supported_graphics_clock>720 MHz</supported_graphics_clock>
                                <supported_graphics_clock>705 MHz</supported_graphics_clock>
                                <supported_graphics_clock>690 MHz</supported_graphics_clock>
                                <supported_graphics_clock>675 MHz</supported_graphics_clock>
                                <supported_graphics_clock>660 MHz</supported_graphics_clock>
                                <supported_graphics_clock>645 MHz</supported_graphics_clock>
                                <supported_graphics_clock>630 MHz</supported_graphics_clock>
                                <supported_graphics_clock>615 MHz</supported_graphics_clock>
                                <supported_graphics_clock>600 MHz</supported_graphics_clock>
                                <supported_graphics_clock>585 MHz</supported_graphics_clock>
                                <supported_graphics_clock>570 MHz</supported_graphics_clock>
                                <supported_graphics_clock>555 MHz</supported_graphics_clock>
                                <supported_graphics_clock>540 MHz</supported_graphics_clock>
                                <supported_graphics_clock>525 MHz</supported_graphics_clock>
                                <supported_graphics_clock>510 MHz</supported_graphics_clock>
                                <supported_graphics_clock>495 MHz</supported_graphics_clock>
                                <supported_graphics_clock>480 MHz</supported_graphics_clock>
                                <supported_graphics_clock>465 MHz</supported_graphics_clock>
                                <supported_graphics_clock>450 MHz</supported_graphics_clock>
                                <supported_graphics_clock>435 MHz</supported_graphics_clock>
                                <supported_graphics_clock>420 MHz</supported_graphics_clock>
                                <supported_graphics_clock>405 MHz</supported_graphics_clock>
                                <supported_graphics_clock>390 MHz</supported_graphics_clock>
                                <supported_graphics_clock>375 MHz</supported_graphics_clock>
                                <supported_graphics_clock>360 MHz</supported_graphics_clock>
                                <supported_graphics_clock>345 MHz</supported_graphics_clock>
                                <supported_graphics_clock>330 MHz</supported_graphics_clock>
                                <supported_graphics_clock>315 MHz</supported_graphics_clock>
                                <supported_graphics_clock>300 MHz</supported_graphics_clock>
                                <supported_graphics_clock>285 MHz</supported_graphics_clock>
                                <supported_graphics_clock>270 MHz</supported_graphics_clock>
                                <supported_graphics_clock>255 MHz</supported_graphics_clock>
                        </supported_mem_clock>
                        <supported_mem_clock>
                                <value>9251 MHz</value>
                                <supported_graphics_clock>2145 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2130 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2115 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2100 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2085 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2070 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2055 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2040 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2025 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2010 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1995 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1980 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1965 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1950 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1935 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1920 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1905 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1890 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1875 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1860 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1845 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1830 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1815 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1800 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1785 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1770 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1755 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1740 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1725 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1710 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1695 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1680 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1665 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1650 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1635 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1620 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1605 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1590 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1575 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1560 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1545 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1530 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1515 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1500 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1485 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1470 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1455 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1440 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1425 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1410 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1395 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1380 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1365 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1350 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1335 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1320 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1305 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1290 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1275 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1260 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1245 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1230 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1215 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1200 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1185 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1170 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1155 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1140 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1125 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1110 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1095 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1080 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1065 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1050 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1035 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1020 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1005 MHz</supported_graphics_clock>
                                <supported_graphics_clock>990 MHz</supported_graphics_clock>
                                <supported_graphics_clock>975 MHz</supported_graphics_clock>
                                <supported_graphics_clock>960 MHz</supported_graphics_clock>
                                <supported_graphics_clock>945 MHz</supported_graphics_clock>
                                <supported_graphics_clock>930 MHz</supported_graphics_clock>
                                <supported_graphics_clock>915 MHz</supported_graphics_clock>
                                <supported_graphics_clock>900 MHz</supported_graphics_clock>
                                <supported_graphics_clock>885 MHz</supported_graphics_clock>
                                <supported_graphics_clock>870 MHz</supported_graphics_clock>
                                <supported_graphics_clock>855 MHz</supported_graphics_clock>
                                <supported_graphics_clock>840 MHz</supported_graphics_clock>
                                <supported_graphics_clock>825 MHz</supported_graphics_clock>
                                <supported_graphics_clock>810 MHz</supported_graphics_clock>
                                <supported_graphics_clock>795 MHz</supported_graphics_clock>
                                <supported_graphics_clock>780 MHz</supported_graphics_clock>
                                <supported_graphics_clock>765 MHz</supported_graphics_clock>
                                <supported_graphics_clock>750 MHz</supported_graphics_clock>
                                <supported_graphics_clock>735 MHz</supported_graphics_clock>
                                <supported_graphics_clock>720 MHz</supported_graphics_clock>
                                <supported_graphics_clock>705 MHz</supported_graphics_clock>
                                <supported_graphics_clock>690 MHz</supported_graphics_clock>
                                <supported_graphics_clock>675 MHz</supported_graphics_clock>
                                <supported_graphics_clock>660 MHz</supported_graphics_clock>
                                <supported_graphics_clock>645 MHz</supported_graphics_clock>
                                <supported_graphics_clock>630 MHz</supported_graphics_clock>
                                <supported_graphics_clock>615 MHz</supported_graphics_clock>
                                <supported_graphics_clock>600 MHz</supported_graphics_clock>
                                <supported_graphics_clock>585 MHz</supported_graphics_clock>
                                <supported_graphics_clock>570 MHz</supported_graphics_clock>
                                <supported_graphics_clock>555 MHz</supported_graphics_clock>
                                <supported_graphics_clock>540 MHz</supported_graphics_clock>
                                <supported_graphics_clock>525 MHz</supported_graphics_clock>
                                <supported_graphics_clock>510 MHz</supported_graphics_clock>
                                <supported_graphics_clock>495 MHz</supported_graphics_clock>
                                <supported_graphics_clock>480 MHz</supported_graphics_clock>
                                <supported_graphics_clock>465 MHz</supported_graphics_clock>
                                <supported_graphics_clock>450 MHz</supported_graphics_clock>
                                <supported_graphics_clock>435 MHz</supported_graphics_clock>
                                <supported_graphics_clock>420 MHz</supported_graphics_clock>
                                <supported_graphics_clock>405 MHz</supported_graphics_clock>
                                <supported_graphics_clock>390 MHz</supported_graphics_clock>
                                <supported_graphics_clock>375 MHz</supported_graphics_clock>
                                <supported_graphics_clock>360 MHz</supported_graphics_clock>
                                <supported_graphics_clock>345 MHz</supported_graphics_clock>
                                <supported_graphics_clock>330 MHz</supported_graphics_clock>
                                <supported_graphics_clock>315 MHz</supported_graphics_clock>
                                <supported_graphics_clock>300 MHz</supported_graphics_clock>
                                <supported_graphics_clock>285 MHz</supported_graphics_clock>
                                <supported_graphics_clock>270 MHz</supported_graphics_clock>
                                <supported_graphics_clock>255 MHz</supported_graphics_clock>
                        </supported_mem_clock>
                        <supported_mem_clock>
                                <value>5001 MHz</value>
                                <supported_graphics_clock>2145 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2130 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2115 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2100 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2085 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2070 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2055 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2040 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2025 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2010 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1995 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1980 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1965 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1950 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1935 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1920 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1905 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1890 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1875 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1860 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1845 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1830 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1815 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1800 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1785 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1770 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1755 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1740 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1725 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1710 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1695 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1680 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1665 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1650 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1635 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1620 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1605 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1590 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1575 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1560 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1545 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1530 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1515 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1500 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1485 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1470 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1455 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1440 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1425 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1410 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1395 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1380 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1365 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1350 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1335 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1320 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1305 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1290 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1275 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1260 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1245 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1230 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1215 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1200 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1185 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1170 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1155 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1140 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1125 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1110 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1095 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1080 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1065 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1050 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1035 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1020 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1005 MHz</supported_graphics_clock>
                                <supported_graphics_clock>990 MHz</supported_graphics_clock>
                                <supported_graphics_clock>975 MHz</supported_graphics_clock>
                                <supported_graphics_clock>960 MHz</supported_graphics_clock>
                                <supported_graphics_clock>945 MHz</supported_graphics_clock>
                                <supported_graphics_clock>930 MHz</supported_graphics_clock>
                                <supported_graphics_clock>915 MHz</supported_graphics_clock>
                                <supported_graphics_clock>900 MHz</supported_graphics_clock>
                                <supported_graphics_clock>885 MHz</supported_graphics_clock>
                                <supported_graphics_clock>870 MHz</supported_graphics_clock>
                                <supported_graphics_clock>855 MHz</supported_graphics_clock>
                                <supported_graphics_clock>840 MHz</supported_graphics_clock>
                                <supported_graphics_clock>825 MHz</supported_graphics_clock>
                                <supported_graphics_clock>810 MHz</supported_graphics_clock>
                                <supported_graphics_clock>795 MHz</supported_graphics_clock>
                                <supported_graphics_clock>780 MHz</supported_graphics_clock>
                                <supported_graphics_clock>765 MHz</supported_graphics_clock>
                                <supported_graphics_clock>750 MHz</supported_graphics_clock>
                                <supported_graphics_clock>735 MHz</supported_graphics_clock>
                                <supported_graphics_clock>720 MHz</supported_graphics_clock>
                                <supported_graphics_clock>705 MHz</supported_graphics_clock>
                                <supported_graphics_clock>690 MHz</supported_graphics_clock>
                                <supported_graphics_clock>675 MHz</supported_graphics_clock>
                                <supported_graphics_clock>660 MHz</supported_graphics_clock>
                                <supported_graphics_clock>645 MHz</supported_graphics_clock>
                                <supported_graphics_clock>630 MHz</supported_graphics_clock>
                                <supported_graphics_clock>615 MHz</supported_graphics_clock>
                                <supported_graphics_clock>600 MHz</supported_graphics_clock>
                                <supported_graphics_clock>585 MHz</supported_graphics_clock>
                                <supported_graphics_clock>570 MHz</supported_graphics_clock>
                                <supported_graphics_clock>555 MHz</supported_graphics_clock>
                                <supported_graphics_clock>540 MHz</supported_graphics_clock>
                                <supported_graphics_clock>525 MHz</supported_graphics_clock>
                                <supported_graphics_clock>510 MHz</supported_graphics_clock>
                                <supported_graphics_clock>495 MHz</supported_graphics_clock>
                                <supported_graphics_clock>480 MHz</supported_graphics_clock>
                                <supported_graphics_clock>465 MHz</supported_graphics_clock>
                                <supported_graphics_clock>450 MHz</supported_graphics_clock>
                                <supported_graphics_clock>435 MHz</supported_graphics_clock>
                                <supported_graphics_clock>420 MHz</supported_graphics_clock>
                                <supported_graphics_clock>405 MHz</supported_graphics_clock>
                                <supported_graphics_clock>390 MHz</supported_graphics_clock>
                                <supported_graphics_clock>375 MHz</supported_graphics_clock>
                                <supported_graphics_clock>360 MHz</supported_graphics_clock>
                                <supported_graphics_clock>345 MHz</supported_graphics_clock>
                                <supported_graphics_clock>330 MHz</supported_graphics_clock>
                                <supported_graphics_clock>315 MHz</supported_graphics_clock>
                                <supported_graphics_clock>300 MHz</supported_graphics_clock>
                                <supported_graphics_clock>285 MHz</supported_graphics_clock>
                                <supported_graphics_clock>270 MHz</supported_graphics_clock>
                                <supported_graphics_clock>255 MHz</supported_graphics_clock>
                        </supported_mem_clock>
                        <supported_mem_clock>
                                <value>810 MHz</value>
                                <supported_graphics_clock>2100 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2085 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2070 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2055 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2040 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2025 MHz</supported_graphics_clock>
                                <supported_graphics_clock>2010 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1995 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1980 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1965 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1950 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1935 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1920 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1905 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1890 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1875 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1860 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1845 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1830 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1815 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1800 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1785 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1770 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1755 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1740 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1725 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1710 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1695 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1680 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1665 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1650 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1635 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1620 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1605 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1590 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1575 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1560 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1545 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1530 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1515 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1500 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1485 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1470 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1455 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1440 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1425 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1410 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1395 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1380 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1365 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1350 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1335 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1320 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1305 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1290 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1275 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1260 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1245 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1230 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1215 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1200 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1185 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1170 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1155 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1140 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1125 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1110 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1095 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1080 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1065 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1050 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1035 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1020 MHz</supported_graphics_clock>
                                <supported_graphics_clock>1005 MHz</supported_graphics_clock>
                                <supported_graphics_clock>990 MHz</supported_graphics_clock>
                                <supported_graphics_clock>975 MHz</supported_graphics_clock>
                                <supported_graphics_clock>960 MHz</supported_graphics_clock>
                                <supported_graphics_clock>945 MHz</supported_graphics_clock>
                                <supported_graphics_clock>930 MHz</supported_graphics_clock>
                                <supported_graphics_clock>915 MHz</supported_graphics_clock>
                                <supported_graphics_clock>900 MHz</supported_graphics_clock>
                                <supported_graphics_clock>885 MHz</supported_graphics_clock>
                                <supported_graphics_clock>870 MHz</supported_graphics_clock>
                                <supported_graphics_clock>855 MHz</supported_graphics_clock>
                                <supported_graphics_clock>840 MHz</supported_graphics_clock>
                                <supported_graphics_clock>825 MHz</supported_graphics_clock>
                                <supported_graphics_clock>810 MHz</supported_graphics_clock>
                                <supported_graphics_clock>795 MHz</supported_graphics_clock>
                                <supported_graphics_clock>780 MHz</supported_graphics_clock>
                                <supported_graphics_clock>765 MHz</supported_graphics_clock>
                                <supported_graphics_clock>750 MHz</supported_graphics_clock>
                                <supported_graphics_clock>735 MHz</supported_graphics_clock>
                                <supported_graphics_clock>720 MHz</supported_graphics_clock>
                                <supported_graphics_clock>705 MHz</supported_graphics_clock>
                                <supported_graphics_clock>690 MHz</supported_graphics_clock>
                                <supported_graphics_clock>675 MHz</supported_graphics_clock>
                                <supported_graphics_clock>660 MHz</supported_graphics_clock>
                                <supported_graphics_clock>645 MHz</supported_graphics_clock>
                                <supported_graphics_clock>630 MHz</supported_graphics_clock>
                                <supported_graphics_clock>615 MHz</supported_graphics_clock>
                                <supported_graphics_clock>600 MHz</supported_graphics_clock>
                                <supported_graphics_clock>585 MHz</supported_graphics_clock>
                                <supported_graphics_clock>570 MHz</supported_graphics_clock>
                                <supported_graphics_clock>555 MHz</supported_graphics_clock>
                                <supported_graphics_clock>540 MHz</supported_graphics_clock>
                                <supported_graphics_clock>525 MHz</supported_graphics_clock>
                                <supported_graphics_clock>510 MHz</supported_graphics_clock>
                                <supported_graphics_clock>495 MHz</supported_graphics_clock>
                                <supported_graphics_clock>480 MHz</supported_graphics_clock>
                                <supported_graphics_clock>465 MHz</supported_graphics_clock>
                                <supported_graphics_clock>450 MHz</supported_graphics_clock>
                                <supported_graphics_clock>435 MHz</supported_graphics_clock>
                                <supported_graphics_clock>420 MHz</supported_graphics_clock>
                                <supported_graphics_clock>405 MHz</supported_graphics_clock>
                                <supported_graphics_clock>390 MHz</supported_graphics_clock>
                                <supported_graphics_clock>375 MHz</supported_graphics_clock>
                                <supported_graphics_clock>360 MHz</supported_graphics_clock>
                                <supported_graphics_clock>345 MHz</supported_graphics_clock>
                                <supported_graphics_clock>330 MHz</supported_graphics_clock>
                                <supported_graphics_clock>315 MHz</supported_graphics_clock>
                                <supported_graphics_clock>300 MHz</supported_graphics_clock>
                                <supported_graphics_clock>285 MHz</supported_graphics_clock>
                                <supported_graphics_clock>270 MHz</supported_graphics_clock>
                                <supported_graphics_clock>255 MHz</supported_graphics_clock>
                                <supported_graphics_clock>240 MHz</supported_graphics_clock>
                                <supported_graphics_clock>225 MHz</supported_graphics_clock>
                                <supported_graphics_clock>210 MHz</supported_graphics_clock>
                        </supported_mem_clock>
                        <supported_mem_clock>
                                <value>405 MHz</value>
                                <supported_graphics_clock>420 MHz</supported_graphics_clock>
                                <supported_graphics_clock>405 MHz</supported_graphics_clock>
                                <supported_graphics_clock>390 MHz</supported_graphics_clock>
                                <supported_graphics_clock>375 MHz</supported_graphics_clock>
                                <supported_graphics_clock>360 MHz</supported_graphics_clock>
                                <supported_graphics_clock>345 MHz</supported_graphics_clock>
                                <supported_graphics_clock>330 MHz</supported_graphics_clock>
                                <supported_graphics_clock>315 MHz</supported_graphics_clock>
                                <supported_graphics_clock>300 MHz</supported_graphics_clock>
                                <supported_graphics_clock>285 MHz</supported_graphics_clock>
                                <supported_graphics_clock>270 MHz</supported_graphics_clock>
                                <supported_graphics_clock>255 MHz</supported_graphics_clock>
                                <supported_graphics_clock>240 MHz</supported_graphics_clock>
                                <supported_graphics_clock>225 MHz</supported_graphics_clock>
                                <supported_graphics_clock>210 MHz</supported_graphics_clock>
                        </supported_mem_clock>
                </supported_clocks>
                <processes>
                        <process_info>
                                <gpu_instance_id>N/A</gpu_instance_id>
                                <compute_instance_id>N/A</compute_instance_id>
                                <pid>1575</pid>
                                <type>G</type>
                                <process_name>/usr/lib/xorg/Xorg</process_name>
                                <used_memory>220 MiB</used_memory>
                        </process_info>
                        <process_info>
                                <gpu_instance_id>N/A</gpu_instance_id>
                                <compute_instance_id>N/A</compute_instance_id>
                                <pid>1933</pid>
                                <type>G</type>
                                <process_name>/usr/bin/gnome-shell</process_name>
                                <used_memory>34 MiB</used_memory>
                        </process_info>
                        <process_info>
                                <gpu_instance_id>N/A</gpu_instance_id>
                                <compute_instance_id>N/A</compute_instance_id>
                                <pid>16484</pid>
                                <type>G</type>
                                <process_name>/opt/microsoft/msedge/msedge --type=gpu-process --crashpad-handler-pid=16445 --enable-crash-reporter=, --change-stack-guard-on-fork=enable --gpu-preferences=WAAAAAAAAAAgAAAEAAAAAAAAAAAAAAAAAABgAAAAAAA4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAGAAAAAAAAAAYAAAAAAAAAAgAAAAAAAAACAAAAAAAAAAIAAAAAAAAAA== --shared-files --field-trial-handle=0,i,8049841253453661893,8316967731219016996,262144</process_name>
                                <used_memory>76 MiB</used_memory>
                        </process_info>
                </processes>
                <accounted_processes>
                </accounted_processes>
        </gpu>

</nvidia_smi_log>
''';

/// [
///   {
///     "name": "GeForce RTX 3090",
///     "temp": 40,
///     "power": "30W / 350W",
///     "memory": {
///       "total": 24268,
///       "used": 240,
///       "unit": "MiB",
///       "processes": [
///         {
///           "pid": 1456,
///           "name": "/usr/lib/xorg/Xorg",
///           "memory": 40
///         },
///       ]
///     },
///   }
/// ]

void main() {
  test('nvdia-smi', () {
    if (kDebugMode) {
      print(NvidiaSmi.fromXml(_raw).firstOrNull?.memory.processes);
    }
  });
}
