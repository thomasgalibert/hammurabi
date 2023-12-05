FactoryBot.define do
  factory :facture_seal do
    association :facture, factory: :facture
    # emetteur_legal_name {  }
    # emetteur_address {  }
    # emetteur_city {  }
    # emetteur_zip_code {  }
    # emetteur_country {  }
    # emetteur_business_number {  }
    # emetteur_vat_number {  }
    # emetteur_share_capital {  }
    # client_name {  }
    # client_address {  }
    # client_city {  }
    # client_zip_code {  }
    # client_country {  }
    # client_business_number {  }
    # client_vat_number {  }
  end
end