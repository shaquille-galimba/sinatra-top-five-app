shaq = User.create(name: "Shaquille Galimba", username: "Shaqriver", password: "Secret")
emily = User.create(name: "Emily Axford", username: "Eaxford", password: "Gilear")

shows = Topic.create(name: "Shows")
npcs = Topic.create(name: "Fantasy High NPCs")

List.create(contents: ["Dimension20", "Community", "The Office", "Breaking bad", "Friends"], user_id: shaq.id, topic_id: shows.id)

List.create(contents: ["Gilear", "Gorthalax", "Ayda Aguefort", "Sandralyn", "Jawbone"], user_id: emily.id, topic_id: npcs.id)
