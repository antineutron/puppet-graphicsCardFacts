require 'facter'

# Custom fact to detect graphics cards. Can also supply things like the manufacturer and model
# if it's in a list of known types, or matches known patterns.
# Mostly cribbed from the built-in processors fact. Restructured for testability
# as per http://unethicalblogger.com/2014/03/01/testing-custom-facts-with-rspec.html
module GraphicsCardFacts
  def self.add_facts

    Facter.add(:graphicscards) do
      
      # Only works on Linux machines for now.
      confine :kernel => :linux
      setcode do
    
        graphicsCards = []
        currentCard = {}
    
        # TODO check for existence of lspci - or ensure package installed?
        # lspci and print key/value pairs per line per device
        Facter::Core::Execution.exec('lspci -vmnn').each_line { |card|
    
          card = card.chomp
    
          # Blank lines appear at the end of each device
          if card =~ /^\s*$/
            # Only add device if it's a VGA compatible controller, class ID 0300
            graphicsCards.push(currentCard) if currentCard['class_numeric'] == '0300'
            currentCard = {}
          
          # e.g. Class: VGA compatible controller [0300]
          elsif card =~ /^(.+):\s*(.+)\s*\[([0-9a-f]+)\]\s*$/
      
            # Convert to name/value pair, with the original numeric value as it might be useful
            name = $1.downcase
            value = $2
            numeric = $3
    
            # Build a hash for the current device
            currentCard[name] = value
            currentCard[name+'_numeric'] = numeric
          end
        }
    
        # Unhelpfully, we don't see the final blank line, so push the remaining card onto the list
        graphicsCards.push(currentCard) if currentCard['class_numeric'] == '0300'
    
        graphicsCards
      end
    end

  end
end 

GraphicsCardFacts.add_facts
