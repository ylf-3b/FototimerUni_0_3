FototimerUni_0_3
================

"Simple" Foto Intervalometer for Canon EOS Cameras with some special features.

based on arduino hardware with simple self developed shield board to interface camera via cable trigger

supported hardware: arduino uno, arduinoo yun, arduino mega adk

this is a early alpha version 

goal for the "Uni" versions are:
- support all the tree hardware type of arduino we have
- rise reliability on Yun hardware
- code optimazations

more later ...

(under development)

================
changes since FototimerUni-0.2
- commented all MegaADK-ifdef and codelines not for YUN use
- implementated logging function for frame info, YUN only, information can be displayed over Wifi with browser
- change ISO switching strategy on failure, for testing only @ positive ramp, ISO switch will be repeated at next cycle

================
changes since FototimerUni-0.1
- 20141228 DP: changed Filename (Arduino IDE doesn't like dashes or dots in the name)
- 20141228 DP: commented all non-MegaADK-ifdefs with //% to avoid preprocessor-related bugs
- 20141228 DP: b02; Display shortened software version incl Build version; display version in LCD for 1s.
- 20141228 DP: b03; Added extra dividers between certain subroutines, esp. the display/setting screens
- 20141228 DP: b03; added CANCEL button as a quick way of breaking out of most Conifg and S-Func screens
- 20141228 DP: b04; mostly visual dividers and a few debug lines
- 20141228 DP: b05; Moved "S-func"/Settings from address 512 to 64 in EEPROM (so that the special stuff
  generated by the PTP libraries definitely fits in)
