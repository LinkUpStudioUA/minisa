class MoneySerializer < ActiveModel::Serializer
  attributes :in_cents, :amount,
             :currency_iso, :currency_symbol,
             :formatted_string

  def in_cents
    object.cents
  end

  def amount
    object.amount.to_f
  end

  def currency_iso
    object.currency.iso_code
  end

  def currency_symbol
    object.currency.symbol
  end

  def formatted_string
    object.format(format: '%u %n')
  end
end
