FactoryGirl.define do
  factory :items_contable do
    categoria_financiera_id 1
    concepto "MyString"
    dinero_publico false
    importe 1
    partido_id 1
  end
end
