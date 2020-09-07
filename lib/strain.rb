require "json_wrapper"

module Strain
  extend self

  LOGO_PLACEHOLDER = "ocs.jpg"

  LOGOS = JSONWrapper.new({
    "18twelve": "18twelve.png",
    "48north": "48north.png",
    "7acres": "7acres.png",
    "7acres reserve": "7acres.png",
    "ace valley": "ace-valley.png",
    "acreage pharms": "acreage-pharms.jpg",
    "ahlot": "ahlot.png",
    "affirma": "affirma.jpg",
    "anky": "anky.png",
    "altavie": "altavie.png",
    "aurora": "aurora.png",
    "beleave": "beleave.png",
    "blkmkt": "blkmkt.jpg",
    "broken coast": "broken-coast.png",
    "canaca": "canaca.jpg",
    "canna farms": "canna-farms.jpg",
    "color cannabis": "weedmd.png",
    "cove": "cove.png",
    "daily special": "daily-special.png",
    "dna genetics": "dna-genetics.png",
    "edison reserve": "edison-reserve.png",
    "edison": "edison.jpg",
    "emerald": "emerald-health.jpg",
    "emerald health": "emerald-health.jpg",
    "emerald health therapeutics": "emerald-health.jpg",
    "figr": "figr.png",
    "fireside": "fireside.jpg",
    "flowr": "flowr.png",
    "gage cannabis co.": "gage.png",
    "good supply": "good-supply.png",
    "grail": "grail.png",
    "grasslands": "grasslands.jpg",
    "hexo": "hexo.png",
    "houseplant": "houseplant.jpeg",
    "haven st.": "haven-st.png",
    "haven st. premium cannabis": "haven-st.png",
    "high tide": "high-tide.png",
    "jwc": "jwc.png",
    "kingsway": "kingsway.png",
    "kiwi cannabis": "kiwi-cannabis.png",
    "lbs": "lbs.png",
    "liiv": "liiv.jpg",
    "marley natural": "marley-natural.png",
    "mezzero": "namaste.jpeg",
    "msiku": "msiku.png",
    "muskoka grown": "muskoka-grown.jpeg",
    "namaste": "namaste.jpeg",
    "northern harvest": "northern-harvest.png",
    "northern green canada": "northern-green-canada.jpg",
    "original stash": "hexo.png",
    "palmetto": "palmetto.png",
    "plain packaging": "plain-packaging.png",
    "pure sunfarms": "pure-sunfarms.jpg",
    "re-up": "re-up.jpg",
    "redecan": "redecan.png",
    "reef": "reef.jpeg",
    "riff": "riff.png",
    "robinsons": "robinsons.jpeg",
    "royal high": "royal-high.png",
    "qwest": "qwest.png",
    "qwest reserve": "qwest.png",
    "san rafael '71": "san-rafael.jpg",
    "saturday": "saturday.jpg",
    "seven oaks": "seven-oaks.png",
    "simple stash": "simple-stash.png",
    "simply bare": "simply-bare.png",
    "solei": "solei.png",
    "spinach": "spinach.png",
    "sundial": "sundial.jpeg",
    "symbl": "symbl.jpg",
    "synr.g": "synr.g.jpg",
    "tantalus labs": "tantalus-labs.png",
    "tenzo": "tenzo.jpg",
    "the green organic dutchman": "tgod.png",
    "thc biomed": "thc-biomed.png",
    "the batch": "the-batch.png",
    "thumbs up": "thumbs-up.jpg",
    "tokyo smoke": "tokyo-smoke.png",
    "top leaf": "top-leaf.png",
    "trailblazer": "trailblazer.png",
    "tweed": "tweed.png",
    "twd.": "tweed.png",
    "twd.28": "tweed.png",
    "up": "up.png",
    "van der pop": "vanderpop.png",
    "vertical": "vertical.png",
    "wdbx": "wdbx.png",
    "weedmd": "weedmd.png",
    "weed me": "weed-me.jpg",
    "whistler cannabis co.": "whistler.jpg",
    "woodstock": "woodstock.png",
    "xscape": "xscape.jpeg"
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
