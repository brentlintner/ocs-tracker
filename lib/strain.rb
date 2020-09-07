require "json_wrapper"

module Strain
  extend self

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

  def self.name shopify_product
    title = shopify_product.title

    shopify_product.tags.inject(nil) do |found_name, tag|
      key, value = tag.split("--")

      valid_street_name = key == "street_name" &&
        value.to_s.downcase != "not applicable" &&
        title.to_s.downcase != value.to_s.downcase

      if valid_street_name then value else found_name end
    end
  end

  def self.logo product
    "brands/#{LOGOS.fetch(product.vendor.to_s.downcase, LOGO_PLACEHOLDER)}"
  end
end
