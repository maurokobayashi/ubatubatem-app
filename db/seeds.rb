# Users
User.delete_all
User.create(email: "mauro.kobayashi@gmail.com", password: "ubatuba2018", first_name: "Mauro", last_name: "Kobayashi", admin: true)
User.create(email: "lunapedricci@gmail.com", password: "lunapedricci@gmail.com", first_name: "Luna", last_name: "Pedricci", admn: true)

# Categs e Subcategs
Categ.delete_all
SubCateg.delete_all
c0 = Categ.create(name: "Não informado", alias: "nao-informado", status: 2)
SubCateg.create(categ: c0, name: "Não informado", alias: "nao-informado", status: 2)
c1 = Categ.create(name: "Alimentação", alias: "alimentacao", icon: "restaurant-outline", order: 1, status: 1)
SubCateg.create(categ: c1, name: "Bebidas", alias: "bebidas", status: 1)
SubCateg.create(categ: c1, name: "Burger e lanches", alias: "burger-e-lanches", status: 1)
SubCateg.create(categ: c1, name: "Cafeterias", alias: "cafeterias", status: 1)
SubCateg.create(categ: c1, name: "Congelados", alias: "congelados", status: 1)
SubCateg.create(categ: c1, name: "Comida japonesa", alias: "comida-japonesa", status: 1)
SubCateg.create(categ: c1, name: "Comidas típicas", alias: "comidas-tipicas", status: 1)
SubCateg.create(categ: c1, name: "Conservas", alias: "conservas", status: 1)
SubCateg.create(categ: c1, name: "Doces e bolos", alias: "doces-e-bolos", status: 1)
SubCateg.create(categ: c1, name: "Grãos e Cereais", alias: "graos-e-cereais", status: 1)
SubCateg.create(categ: c1, name: "Hortifrutis", alias: "hortifrutis", status: 1)
SubCateg.create(categ: c1, name: "Padarias", alias: "padarias", status: 1)
SubCateg.create(categ: c1, name: "Pães artesanais", alias: "paes-artesanais", status: 1)
SubCateg.create(categ: c1, name: "Pescados", alias: "pescados", status: 1)
SubCateg.create(categ: c1, name: "Pizza e esfirra", alias: "pizza-e-esfirra", status: 1)
SubCateg.create(categ: c1, name: "Prato feito e marmitex", alias: "prato-feito-e-marmitex", status: 1)
SubCateg.create(categ: c1, name: "Refeições", alias: "refeicoes", status: 1)
SubCateg.create(categ: c1, name: "Salgados", alias: "salgados", status: 1)
SubCateg.create(categ: c1, name: "Sorvetes e açaí", alias: "sorvetes-e-acai", status: 1)
c2 = Categ.create(name: "Moda", alias: "moda", icon: "shirt-outline", order: 3, status: 1)
SubCateg.create(categ: c2, name: "Bolsas e acessórios", alias: "bolsas-e-acessorios", status: 1)
SubCateg.create(categ: c2, name: "Brechós", alias: "brechos", status: 1)
SubCateg.create(categ: c2, name: "Calçados", alias: "calcados", status: 1)
SubCateg.create(categ: c2, name: "Moda feminina", alias: "feminina", status: 1)
SubCateg.create(categ: c2, name: "Moda infantil", alias: "infantil", status: 1)
SubCateg.create(categ: c2, name: "Jóias e semijóias", alias: "joias-e-semijoias", status: 1)
SubCateg.create(categ: c2, name: "Moda Masculina", alias: "masculina", status: 1)
SubCateg.create(categ: c2, name: "Óticas", alias: "oticas", status: 1)
SubCateg.create(categ: c2, name: "Moda praia", alias: "praia", status: 1)
SubCateg.create(categ: c2, name: "Surfshops", alias: "surfshops", status: 1)
c3 = Categ.create(name: "Saúde e beleza", icon: "heart", alias: "saude-e-beleza", order: 4, status: 1)
SubCateg.create(categ: c3, name: "Cosméticos naturais", alias: "cosmeticos-naturais", status: 1)
SubCateg.create(categ: c3, name: "Maquiagem", alias: "maquiagem", status: 1)
SubCateg.create(categ: c3, name: "Perfumarias", alias: "perfumarias", status: 1)
SubCateg.create(categ: c3, name: "Farmácias", alias: "farmacias", status: 1)
SubCateg.create(categ: c3, name: "Farmácias de manipulação", alias: "farmacias-de-manipulacao", status: 1)
c4 = Categ.create(name: "Pets", alias: "pets", icon: "paw-outline", order: 5, status: 1)
SubCateg.create(categ: c4, name: "Petshops", alias: "petshop", status: 1)
SubCateg.create(categ: c4, name: "Hospedagem e creche", alias: "hospedagem-e-creche", status: 1)
SubCateg.create(categ: c4, name: "Banho e tosa", alias: "banho-e-tosa", status: 1)
SubCateg.create(categ: c4, name: "Clínicas veterinárias", alias: "clinicas-veterinarias", status: 1)
c5 = Categ.create(name: "Feito à mão", alias: "feito-a-mao", icon: "hand-left-outline", order: 2, status: 1)
SubCateg.create(categ: c5, name: "Artesanato", alias: "artesanato", status: 1)
SubCateg.create(categ: c5, name: "Casa e decoração", alias: "casa-e-decoracao", status: 1)
SubCateg.create(categ: c5, name: "Crochê e costura", alias: "croche-e-costura", status: 1)
SubCateg.create(categ: c5, name: "Produtos ecológicos", alias: "produtos-ecologicos", status: 1)
c6 = Categ.create(name: "Lojas", alias: "lojas", icon: "gift-outline", order: 6, status: 1)
SubCateg.create(categ: c6, name: "Armarinhos", alias: "armarinhos", status: 1)
SubCateg.create(categ: c6, name: "Bebê e gestante", alias: "bebe-e-gestante", status: 1)
SubCateg.create(categ: c6, name: "Celular e informática", alias: "celular-e-informatica", status: 1)
SubCateg.create(categ: c6, name: "Papelarias", alias: "papelarias", status: 1)
SubCateg.create(categ: c6, name: "Presentes", alias: "presentes", status: 1)
SubCateg.create(categ: c6, name: "Reforma e construção", alias: "reforma-e-construcao", status: 1)
c7 = Categ.create(name: "Serviços", alias: "servicos", icon: "build-outline", order: 7, status: 1)
SubCateg.create(categ: c7, name: "Assistências técnicas", alias: "assistencias-tecnicas", status: 1)
SubCateg.create(categ: c7, name: "Chaveiros", alias: "chaveiros", status: 1)
SubCateg.create(categ: c7, name: "Consertos de prancha", alias: "consertos-de-prancha", status: 1)
SubCateg.create(categ: c7, name: "Fotografia", alias: "fotografia", status: 1)
SubCateg.create(categ: c7, name: "Organizações Culturais", alias: "organizacoes-culturais", status: 1)

# Bairros
Bairro.delete_all
Bairro.create!([
  {name: "Itaguá", lat: -23.4549484, lng: -45.0754529, regiao: "centro"},
  {name: "Estufa I", lat: -23.4483411, lng: -45.0961145, regiao: "centro"},
  {name: "Estufa II", lat: -23.4538167, lng: -45.0857998, regiao: "centro"},
  {name: "Centro", lat: -23.4358973, lng: -45.0834438, regiao: "centro"},
  {name: "Umuarama (Centro)", lat: -23.4373594, lng: -45.0904114, regiao: "centro"},
  {name: "Silop (Centro)", lat: -23.4378956, lng: -45.088693, regiao: "centro"},
  {name: "Jardim Carolina", lat: -23.4382016, lng: -45.1007926, regiao: "centro"},
  {name: "Marafunda", lat: -23.4361867, lng: -45.1115513, regiao: "centro"},
  {name: "Ressaca", lat: -23.43099, lng: -45.093326, regiao: "centro"},
  {name: "Jardim Samambaia", lat: -23.4377613, lng: -45.09783, regiao: "centro"},
  {name: "Ipiranguinha", lat: -23.4272405, lng: -45.1254705, regiao: "serra"},
  {name: "Horto", lat: -23.4181255, lng: -45.1259037, regiao: "serra"},
  {name: "Figueira", lat: -23.3973141, lng: -45.1383287, regiao: "serra"},
  {name: "Sesmaria", lat: -23.4658114, lng: -45.095852, regiao: "serra"},
  {name: "Perequê Açu", lat: -23.4204397, lng: -45.0748701, regiao: "norte"},
  {name: "Sumidouro", lat: -23.4110539, lng: -45.0733212, regiao: "norte"},
  {name: "Taquaral", lat: -23.4019155, lng: -45.0767058, regiao: "norte"},
  {name: "Barra Seca", lat: -23.4188967, lng: -45.0528719, regiao: "norte"},
  {name: "Itamambuca", lat: -23.4025298, lng: -45.018162, regiao: "norte"},
  {name: "Félix", lat: -23.3917583, lng: -44.9814515, regiao: "norte"},
  {name: "Prumirim", lat: -23.3774283, lng: -44.969543, regiao: "norte"},
  {name: "Puruba", lat: -23.3434844, lng: -44.9468121, regiao: "norte"},
  {name: "Ubatumirim", lat: -23.3373699, lng: -44.9160083, regiao: "norte"},
  {name: "Ubatumirim (Sertão)", lat: -23.3051518, lng: -44.8706138, regiao: "norte"},
  {name: "Almada", lat: -23.3592769, lng: -44.889551, regiao: "norte"},
  {name: "Fazenda (Praia)", lat: -23.3776971, lng: -44.8557892, regiao: "norte"},
  {name: "Camburi", lat: -23.3686814, lng: -44.8099711, regiao: "norte"},
  {name: "Tenório", lat: -23.4609125, lng: -45.0699523, regiao: "centro"},
  {name: "Vermelha do Centro", lat: -23.4616605, lng: -45.0598242, regiao: "centro"},
  {name: "Praia Grande", lat: -23.4700892, lng: -45.0770014, regiao: "sul"},
  {name: "Toninhas", lat: -23.4955835, lng: -45.0901383, regiao: "sul"},
  {name: "Enseada", lat: -23.4918765, lng: -45.0910537, regiao: "sul"},
  {name: "Perequê Mirim", lat: -23.4889623, lng: -45.1169509, regiao: "sul"},
  {name: "Saco da Ribeira", lat: -23.5033937, lng: -45.1321095, regiao: "sul"},
  {name: "Lázaro", lat: -23.502764, lng: -45.1390618, regiao: "sul"},
  {name: "Domingas Dias (Lázaro)", lat: -23.5008356, lng: -45.1441902, regiao: "sul"},
  {name: "Rio Escuro", lat: -23.4806348, lng: -45.1646286, regiao: "sul"},
  {name: "Folha Seca", lat: -23.4792042, lng: -45.183909, regiao: "sul"},
  {name: "Corcovado", lat: -23.481324, lng: -45.1929208, regiao: "sul"},
  {name: "Praia Vermelha do Sul", lat: -23.5102323, lng: -45.1809228, regiao: "sul"},
  {name: "Praia da Fortaleza", lat: -23.5295881, lng: -45.1763013, regiao: "sul"},
  {name: "Lagoinha", lat: -23.5184064, lng: -45.2161479, regiao: "sul"},
  {name: "Sapê", lat: -23.5273361, lng: -45.2349808, regiao: "sul"},
  {name: "Maranduba", lat: -23.5423433, lng: -45.2418902, regiao: "sul"},
  {name: "Sertão da Quina", lat: -23.5313454, lng: -45.2560564, regiao: "sul"}
])


