# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(first_name: 'Collin', last_name: 'Barnwell',
            image_url: 'http://advitamaeternam.org/wp-content/uploads/2014/11/Goat.jpg',
            orientation: 'straight', gender: true)

User.create(first_name: 'Phil', last_name: 'Collins',
            image_url: 'http://advitamaeternam.org/wp-content/uploads/2014/11/Goat.jpg',
            orientation: 'gay', gender: true)

User.create(first_name: 'Nour', last_name: 'Alharithi',
            image_url: 'https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwi5kvGg9vfLAhXoloMKHfVqCb4QjBwIBA&url=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fb%2Fb2%2FHausziege_04.jpg&psig=AFQjCNE8ag5l9VNu7uw1XNzLZK03jD3QIw&ust=1459960345681504',
            orientation: 'straight', gender: true)

User.create(first_name: 'Jerry', last_name: 'Li',
            image_url: 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Domestic_goat_kid_in_capeweed.jpg',
            orientation: 'straight', gender: true)

User.create(first_name: 'Zavier', last_name: 'Henry',
            image_url: 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Domestic_goat_kid_in_capeweed.jpg',
            orientation: 'gay', gender: true)

User.create(first_name: 'Yicheng', last_name: 'Wang',
            image_url: 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Domestic_goat_kid_in_capeweed.jpg',
            orientation: 'straight', gender: true)

User.create(first_name: 'Jerrina', last_name: 'Li',
            image_url: 'http://www.grit.com/~/media/Images/GRT/Editorial/Articles/Magazine%20Articles/2010/01-01/Raising%20Goats%20for%20Fun%20and%20Profit/Grt-JF10-goats-kid-i.jpg',
            orientation: 'straight', gender: false)

User.create(first_name: 'Lena', last_name: 'Barnes',
            image_url: 'http://advitamaeternam.org/wp-content/uploads/2014/11/Goat.jpg',
            orientation: 'gay', gender: false)

User.create(first_name: 'Nira', last_name: 'Alhari',
            image_url: 'https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwi5kvGg9vfLAhXoloMKHfVqCb4QjBwIBA&url=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fb%2Fb2%2FHausziege_04.jpg&psig=AFQjCNE8ag5l9VNu7uw1XNzLZK03jD3QIw&ust=1459960345681504',
            orientation: 'straight', gender: false)

User.create(first_name: 'Henrieta', last_name: 'Zavier',
            image_url: 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Domestic_goat_kid_in_capeweed.jpg',
            orientation: 'straight', gender: false)

User.create(first_name: 'Yichi', last_name: 'Wong',
            image_url: 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Domestic_goat_kid_in_capeweed.jpg',
            orientation: 'bi', gender: false)
