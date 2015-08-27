require 'spec_helper'
require 'facts/graphicscards'
# Partly cribbed from http://unethicalblogger.com/2014/03/01/testing-custom-facts-with-rspec.html

# Fake lspci output, taken from a virtualbox VM and adding an nvidia card
device_list = "Device:      00:00.0
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

Device:	01:00.0
Class:	VGA compatible controller [0300]
Vendor:	NVIDIA Corporation [10de]
Device:	GF116 [GeForce GTX 550 Ti] [1244]
SVendor:	eVga.com. Corp. [3842]
SDevice:	Device [1557]
Rev:    a1

"

describe 'graphicscards', :type => :fact do

  # Clear out facter before and after testing
  before {Facter.clear}
  after {Facter.clear}

  # Only works on linux, this is the only fact it reads
  let(:facts) do {:kernel => 'linux'} end
  subject(:fact) { Facter.fact(:graphicscards) }


#  it "should flag existence of nvidia graphics cards" do
#    #Facter::Util::Resolution.stubs(:exec).with("lspci -vmnn").returns('TOAST')#device_list)
#    expect(Facter.fact(:has_intel_graphicscard).value).to eq(false)
#    expect(Facter.fact(:has_amd_graphicscard).value).to eq(false)
#    expect(Facter.fact(:has_nvidia_graphicscard).value).to eq(true)
#  end

  it "should return correct graphics card list" do

    # Fake out the lspci output
    Facter::Util::Resolution.stubs(:exec).with("lspci -vmnn").returns(device_list)
    expect(Facter.fact(:graphicscards).value).to eq([
      {"class"=>"VGA compatible controller",
       "class_numeric"=>"0300",
       "vendor"=>"InnoTek Systemberatung GmbH",
       "vendor_numeric"=>"80ee",
       "device"=>"VirtualBox Graphics Adapter",
       "device_numeric"=>"beef",
      },
      {"class"=>"VGA compatible controller",
       "class_numeric"=>"0300",
       "vendor"=>"NVIDIA Corporation",
       "vendor_numeric"=>"10de",
       "device"=>"GF116 [GeForce GTX 550 Ti]",
       "device_numeric"=>"1244",
       "svendor"=>"eVga.com. Corp.",
       "svendor_numeric"=>"3842",
       "sdevice"=>"Device",
       "sdevice_numeric"=>"1557",
      },
    ])
  end 
  #expect(subject.value).to eql("i'm in your puppet!")

#      Facter.fact(:graphicscards).value.should == [{}]
#  end

  # Clean up facter after each test
  after :each do
    Facter.clear
    Facter.clear_messages
  end
end

describe 'has_intel_graphicscard', :type => :fact do

  # Clear out facter before and after testing
  before {Facter.clear}
  after {Facter.clear}

  # Only works on linux, this is the only fact it reads
  let(:facts) do {:kernel => 'linux'} end
  subject(:fact) { Facter.fact(:graphicscards) }


  it "should not flag existence of intel graphics cards" do
    Facter::Util::Resolution.stubs(:exec).with("lspci -vmnn").returns(device_list)
    expect(Facter.fact(:has_intel_graphicscard).value).to eq(false)
  end
end

describe 'has_nvidia_graphicscard', :type => :fact do

  # Clear out facter before and after testing
  before {Facter.clear}
  after {Facter.clear}

  # Only works on linux, this is the only fact it reads
  let(:facts) do {:kernel => 'linux'} end
  subject(:fact) { Facter.fact(:graphicscards) }


  it "should flag existence of nvidia graphics cards" do
    Facter::Util::Resolution.stubs(:exec).with("lspci -vmnn").returns(device_list)
    expect(Facter.fact(:has_nvidia_graphicscard).value).to eq(true)
  end
end

describe 'has_amd_graphicscard', :type => :fact do

  # Clear out facter before and after testing
  before {Facter.clear}
  after {Facter.clear}

  # Only works on linux, this is the only fact it reads
  let(:facts) do {:kernel => 'linux'} end
  subject(:fact) { Facter.fact(:graphicscards) }


  it "should not flag existence of amd graphics cards" do
    Facter::Util::Resolution.stubs(:exec).with("lspci -vmnn").returns(device_list)
    expect(Facter.fact(:has_amd_graphicscard).value).to eq(false)
  end
end
