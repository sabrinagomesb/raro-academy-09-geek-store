# frozen_string_literal: true

require "faker"

# Create States and Cities from JSON file
filepath = ENV.fetch("FILEPATH", Rails.root.join("db", "states_cities.json"))
states = JSON.parse(File.read(filepath))

states.each do |state|
  state_obj = State.find_or_create_by(acronym: state["acronym"], name: state["name"])

  state["cities"].each do |city|
    City.find_or_create_by(name: city["name"], state: state_obj)
    puts "Adicionando a cidade #{city['name']} ao estado #{state_obj.name}"
  end
end

state = State.find_by(acronym: "CE")
cities = City.includes(:state).where(state: { id: state.id })

# Create Customers
50.times do
  name = Faker::Name.name_with_middle
  cpf = Faker::IDNumber.brazilian_cpf
  address = Address.create(
    city_id: cities.sample.id,
    public_place: Faker::Address.street_name,
    zip_code: Faker::Number.number(digits: 8).to_s,
    number: Faker::Address.building_number.to_s,
    neighborhood: Faker::Address.community,
    reference: Faker::Address.secondary_address,
    complement: Faker::Address.secondary_address,
    addressable: Customer.create(name:, cpf:)
  )
  puts "Adicionando cliente #{name} com CPF #{cpf}, morador de #{address.city.name}"
end

# Create Stores
50.times do
  name = Faker::Company.name
  cnpj = Faker::Company.brazilian_company_number
  address = Address.create(
    city_id: cities.sample.id,
    public_place: Faker::Address.street_name,
    zip_code: Faker::Number.number(digits: 8).to_s,
    number: Faker::Address.building_number.to_s,
    neighborhood: Faker::Address.community,
    reference: Faker::Address.secondary_address,
    complement: Faker::Address.secondary_address,
    addressable: Store.create(name:, cnpj:)
  )
  puts "Adicionando loja #{name} com CNPJ #{cnpj}, localizada em #{address.city.name}"
end

# Create Suppliers
50.times do
  name = Faker::Commerce.vendor
  cnpj = Faker::Company.brazilian_company_number
  address = Address.create(
    city_id: cities.sample.id,
    public_place: Faker::Address.street_name,
    zip_code: Faker::Number.number(digits: 8).to_s,
    number: Faker::Address.building_number.to_s,
    neighborhood: Faker::Address.community,
    reference: Faker::Address.secondary_address,
    complement: Faker::Address.secondary_address,
    addressable: Supplier.create(name:, cnpj:)
  )
  puts "Adicionando fornecedor #{name} com CNPJ #{cnpj}, localizado em #{address.city.name}"
end

# Create Products
100.times do
  name = Faker::Commerce.product_name
  unit_price = Faker::Commerce.price.round(2)
  description = Faker::Lorem.paragraph
  Product.create(name:, unit_price:, description:)
  puts "Adicionando produto #{name} com preço #{unit_price}"
end

suppliers = Supplier.all
products = Product.all
customers = Customer.all
stores = Store.all

# Create ProductSuppliers
products.each do |product|
  supplier = suppliers.sample
  ProductSupplier.create(product:, supplier:)
  puts "Adicionando o produto #{product.name} ao fornecedor #{supplier.name}"
end

# Create StoreProducts
stores.each do |store|
  amount_of_products = Faker::Number.number(digits: 1)
  amount_of_products.times do
    product = products.sample
    amount = Faker::Number.number(digits: 2)
    StoreProduct.create(store:, product:, amount:)
    puts "Adicionando o produto #{product.name} à loja #{store.name}"
  end
end

# Create Sales
stores.each do |store|
  amount_of_sales = Faker::Number.number(digits: 1)

  amount_of_sales.times do
    customer = customers.sample
    invoice = Faker::Number.number(digits: 10).to_s
    sale = Sale.create(store:, customer:, invoice:)
    amount_of_products = Faker::Number.number(digits: 1)
    amount_of_products.times do
      product = products.sample
      amount = Faker::Number.number(digits: 1)
      SaleProduct.create(sale:, product:, amount:)
      puts "Adicionando o produto #{product.name} à venda #{sale.id}"
    end
    puts "Adicionando a venda #{sale.id} à loja #{store.name} para o cliente #{customer.name}"
  end
end
