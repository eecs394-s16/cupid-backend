# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



# https://randomuser.me/api/portraits/men/80.jpg




User.create(name: 'Collin Barnwell',
            image_url: 'http://advitamaeternam.org/wp-content/uploads/2014/11/Goat.jpg',
            orientation: 'straight', gender: true, email: 'hello@example.com')

User.create(name: 'Phil Collins',
            image_url: 'http://advitamaeternam.org/wp-content/uploads/2014/11/Goat.jpg',
            orientation: 'gay', gender: true, email: 'hai@example.com')

User.create(name: 'Nour Alharithi',
            image_url: 'https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwi5kvGg9vfLAhXoloMKHfVqCb4QjBwIBA&url=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fb%2Fb2%2FHausziege_04.jpg&psig=AFQjCNE8ag5l9VNu7uw1XNzLZK03jD3QIw&ust=1459960345681504',
            orientation: 'straight', gender: true, email: 'asd@lsdfk.com')

User.create(name: 'Jerry Li',
            image_url: 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Domestic_goat_kid_in_capeweed.jpg',
            orientation: 'straight', gender: true, email: 'jerry@li.com')

User.create(name: 'Zavier Henry',
            image_url: 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Domestic_goat_kid_in_capeweed.jpg',
            orientation: 'gay', gender: true, email: 'waI@LASDF.COM')

User.create(name: 'Yicheng Wang',
            image_url: 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Domestic_goat_kid_in_capeweed.jpg',
            orientation: 'straight', gender: true, email: 'yicheng@wang.com')

User.create(name: 'Jerrina Li',
            image_url: 'http://www.grit.com/~/media/Images/GRT/Editorial/Articles/Magazine%20Articles/2010/01-01/Raising%20Goats%20for%20Fun%20and%20Profit/Grt-JF10-goats-kid-i.jpg',
            orientation: 'straight', gender: false, email: 'jerrina@li.com')

User.create(name: 'Lena Barnes',
            image_url: 'http://advitamaeternam.org/wp-content/uploads/2014/11/Goat.jpg',
            orientation: 'gay', gender: false, email: 'lena@wa.com')

User.create(name: 'Nira Alhari',
            image_url: 'https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwi5kvGg9vfLAhXoloMKHfVqCb4QjBwIBA&url=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fb%2Fb2%2FHausziege_04.jpg&psig=AFQjCNE8ag5l9VNu7uw1XNzLZK03jD3QIw&ust=1459960345681504',
            orientation: 'straight', gender: false, email: 'nira@li.com')

User.create(name: 'Henrieta Zavier',
            image_url: 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Domestic_goat_kid_in_capeweed.jpg',
            orientation: 'straight', gender: false, email: 'henrieta@li.com')

User.create(name: 'Yichi Wong',
            image_url: 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Domestic_goat_kid_in_capeweed.jpg',
            orientation: 'bi', gender: false, email: 'yichi@wong.com')



Match.create_valid_matches
