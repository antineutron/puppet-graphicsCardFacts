require 'facter'

# Custom fact to detect graphics cards. Can also supply things like the manufacturer and model
# if it's in a list of known types, or matches known patterns.
# Mostly cribbed from the built-in processors fact. Restructured for testability
# as per http://unethicalblogger.com/2014/03/01/testing-custom-facts-with-rspec.html
module GraphicsCardFacts

  @@graphicsCards = nil

  def self.list_cards
    if @@graphicsCards != nil
      @@graphicsCards
    end

    @@graphicsCards = []
    currentCard = {}

    # TODO check for existence of lspci - or ensure package installed?
    # lspci and print key/value pairs per line per device
    Facter::Util::Resolution.exec('lspci -vmnn').each_line { |card|
      card = card.chomp

      # Blank lines appear at the end of each device
      if card =~ /^\s*$/
        # Only add device if it's a VGA compatible controller, class ID 0300
        @@graphicsCards.push(currentCard) if currentCard['class_numeric'] == '0300'
        currentCard = {}
      
      # e.g. Class: VGA compatible controller [0300]
      elsif card =~ /^(.+):\s*(.+)\s*\[([0-9a-f]+)\]\s*$/
    
        # Convert to name/value pair, with the original numeric value as it might be useful
        name = $1.strip.downcase
        value = $2.strip
        numeric = $3.strip.downcase
    
        # Build a hash for the current device
        currentCard[name] = value
        currentCard[name+'_numeric'] = numeric
      end
    }

    # Unhelpfully, we don't see the final blank line, so push the remaining card onto the list
    @@graphicsCards.push(currentCard) if currentCard['class_numeric'] == '0300'
    
    @@graphicsCards
  end

  def self.add_facts

    Facter.add(:graphicscards) do
      
      # Only works on Linux machines for now.
      confine :kernel => :linux
      setcode do
        GraphicsCardFacts.list_cards
      end
    end

    # Handy facts to tell if we have a card by nvidia, AMD or Intel (based on vendor ID)
    Facter.add(:has_nvidia_graphicscard) do
      confine :kernel => :linux
      setcode do
        value = false
        for card in GraphicsCardFacts.list_cards
          if card['vendor_numeric'] == '10de'
            value = true
          end
        end
        value
      end
    end

    Facter.add(:has_amd_graphicscard) do
      confine :kernel => :linux
      setcode do
        value = false
        for card in GraphicsCardFacts.list_cards
          if card['vendor_numeric'] == '1002' or card['vendor_numeric'] == '1022'
            value = true
          end
        end
        value
      end
    end

    Facter.add(:has_intel_graphicscard) do
      confine :kernel => :linux
      setcode do
        value = false
        for card in GraphicsCardFacts.list_cards
          if card['vendor_numeric'] == '8086' or card['vendor_numeric'] == '8087' or card['vendor_numeric'] == '163c'
            value = true
          end
        end
        value
      end
    end
  end
end 

GraphicsCardFacts.add_facts
