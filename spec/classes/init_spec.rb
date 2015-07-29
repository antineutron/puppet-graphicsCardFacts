require 'spec_helper'
# Partly cribbed from http://unethicalblogger.com/2014/03/01/testing-custom-facts-with-rspec.html

describe 'Facter::Util::Fact' do

  # Load facts before each test
 # before :each do
 #   GraphicsCardFacts.add_facts
 # end

  describe 'graphicscards' do
    allow(Facter::Util::Resolution).to receive(:exec).with("lspci -vmnn").
      and_return("Device:	00:00.0
Class:	Host bridge [0600]
Vendor:	Intel Corporation [8086]
Device:	440FX - 82441FX PMC [Natoma] [1237]
Rev:	02

Device:	00:01.0
Class:	ISA bridge [0601]
Vendor:	Intel Corporation [8086]
Device:	82371SB PIIX3 ISA [Natoma/Triton II] [7000]

Device:	00:01.1
Class:	IDE interface [0101]
Vendor:	Intel Corporation [8086]
Device:	82371AB/EB/MB PIIX4 IDE [7111]
Rev:	01
ProgIf:	8a

Device:	00:02.0
Class:	VGA compatible controller [0300]
Vendor:	InnoTek Systemberatung GmbH [80ee]
Device:	VirtualBox Graphics Adapter [beef]

Device:	00:03.0
Class:	Ethernet controller [0200]
Vendor:	Intel Corporation [8086]
Device:	82540EM Gigabit Ethernet Controller [100e]
SVendor:	Intel Corporation [8086]
SDevice:	PRO/1000 MT Desktop Adapter [001e]
Rev:	02

Device:	00:04.0
Class:	System peripheral [0880]
Vendor:	InnoTek Systemberatung GmbH [80ee]
Device:	VirtualBox Guest Service [cafe]

Device:	00:07.0
Class:	Bridge [0680]
Vendor:	Intel Corporation [8086]
Device:	82371AB/EB/MB PIIX4 ACPI [7113]
Rev:	08

")
      Facter.fact(:graphicscards).value.should == [{}]
  end

  # Clean up facter after each test
  after :each do
    Facter.clear
    Facter.clear_messages
  end
end
