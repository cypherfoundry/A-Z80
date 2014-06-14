onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /test_pins/ab
add wave -noupdate /test_pins/ctl_ab_we
add wave -noupdate /test_pins/ctl_ab_pin_oe
add wave -noupdate -radix hexadecimal /test_pins/apin
add wave -noupdate -color Gold -itemcolor Gold /test_pins/ctl_db_we
add wave -noupdate -color Gold -itemcolor Gold /test_pins/ctl_db_pin_re
add wave -noupdate -color Gold -itemcolor Gold /test_pins/ctl_db_pin_oe
add wave -noupdate -color Gold -itemcolor Gold /test_pins/ctl_db_oe
add wave -noupdate -color Gold -itemcolor Gold -radix hexadecimal /test_pins/db_w
add wave -noupdate -color {Lime Green} -itemcolor Gold -radix hexadecimal /test_pins/db
add wave -noupdate -color Gold -itemcolor Gold -radix hexadecimal /test_pins/dpin_w
add wave -noupdate -color {Lime Green} -itemcolor Gold -radix hexadecimal /test_pins/dpin
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
configure wave -valuecolwidth 118
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits ps
update
WaveRestoreZoom {200 ps} {1 ns}