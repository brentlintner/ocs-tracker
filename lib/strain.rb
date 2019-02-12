require "json_wrapper"

module Strain
  extend self

  MAP = JSONWrapper.new({
    "ace-valley-cbd": "Durga Mata II",
    "ace-valley-sativa": "BC Ice Cream",
    "airplane-mode": "Critical Kush",
    "banana-split": "Luna",
    "black": "Wappa",
    "cabaret": "Island Sweet Skunk",
    "campfire": "Buddha’s Sister",
    "city-lights": "Critical Kush",
    "dream-weaver": "MK Ultra",
    "easy-cheesy": "UK Cheese",
    "free": "Treasure Island",
    "galiano": "Northern Lights Haze",
    "gather": "Jack Herer",
    "houndstooth": "Candyland",
    "keats": "White Walker Kush",
    "kinky-kush": "Gold Kush",
    "lola-montes": "Hashplant",
    "lola-montes-reserve": "Hashplant",
    "moonbeam": "Strawberry Banana",
    "quadra": "Headstash",
    "red": "Spoetnik #1",
    "reflect": "OG Kush",
    "rest": "Pink Kush",
    "rio-bravo": "Wabanaki",
    "rise": "Green Crack",
    "rise-2": "Green Crack",
    "ruxton": "Sour OG",
    "san-fernando-valley-1": "SFV OG",
    "solar-power-symbl": "Sour Kush",
    "sunset": "Sour Kush",
    "super-sonic": "Quantum Kush",
    "unplug": "Sour Kush",
    "yin-yang": "Pennywise"
  })

  LOGO_PLACEHOLDER = "ocs.jpg"

  LOGOS = JSONWrapper.new({
    "7acres": "7acres.png",
    "ace valley": "ace-valley.png",
    "altavie": "altavie.png",
    "aurora": "aurora.png",
    "broken coast": "broken-coast.png",
    "canaca": "canaca.jpg",
    "canna farms": "canna-farms.jpg",
    "cove": "cove.png",
    "dna genetics": "dna-genetics.png",
    "edison reserve": "edison-reserve.png",
    "edison": "edison.jpg",
    "fireside": "fireside.jpg",
    "flowr": "flowr.png",
    "haven st.": "haven-st.png",
    "high tide": "high-tide.png",
    "kiwi cannabis": "kiwi-cannabis.png",
    "lbs": "lbs.png",
    "liiv": "liiv.jpg",
    "northern harvest": "northern-harvest.png",
    "plain packaging": "plain-packaging.jpg",
    "redecan": "redecan.png",
    "riff": "riff.png",
    "royal high": "royal-high.png",
    "san rafael '71": "san-rafael.jpg",
    "seven oaks": "seven-oaks.png",
    "solei": "solei.png",
    "spinach": "spinach.png",
    "symbl": "symbl.jpg",
    "synr.g": "synr.g.jpg",
    "tokyo smoke": "tokyo-smoke.png",
    "tweed": "tweed.png",
    "up": "up.png",
    "wdbx": "wdbx.png",
    "weedmd": "weedmd.png",
    "woodstock": "woodstock.png",
    "vertical": "vertical.png"
  })

  def self.name product
    MAP.fetch(product.handle, nil)
  end

  def self.logo product
    "brands/#{LOGOS.fetch(product.vendor.to_s.downcase, LOGO_PLACEHOLDER)}"
  end
end
