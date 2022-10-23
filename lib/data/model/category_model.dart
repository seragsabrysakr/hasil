class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.parent,
    required this.description,
    required this.display,
    required this.image,
    required this.menuOrder,
    required this.count,
    required this.links,
  });
  late final int id;
  late final String name;
  late final String slug;
  late final int parent;
  late final String description;
  late final String display;
  late final Image image;
  late final int menuOrder;
  late final int count;
  late final Links links;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parent = json['parent'];
    description = json['description'];
    display = json['display'];
    image = Image.fromJson(json['image'] ?? {});
    menuOrder = json['menu_order'];
    count = json['count'];
    links = Links.fromJson(json['_links']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['parent'] = parent;
    _data['description'] = description;
    _data['display'] = display;
    _data['image'] = image.toJson();
    _data['menu_order'] = menuOrder;
    _data['count'] = count;
    _data['_links'] = links.toJson();
    return _data;
  }
}

class Image {
  Image({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.src,
    required this.name,
    required this.alt,
  });
  late final int id;
  late final String dateCreated;
  late final String dateCreatedGmt;
  late final String dateModified;
  late final String dateModifiedGmt;
  late final String src;
  late final String name;
  late final String alt;

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    dateCreated = json['date_created'] ?? '';
    dateCreatedGmt = json['date_created_gmt'] ?? '';
    dateModified = json['date_modified'] ?? '';
    dateModifiedGmt = json['date_modified_gmt'] ?? "";
    src = json['src'] ?? '';
    name = json['name'] ?? '';
    alt = json['alt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['date_created'] = dateCreated;
    _data['date_created_gmt'] = dateCreatedGmt;
    _data['date_modified'] = dateModified;
    _data['date_modified_gmt'] = dateModifiedGmt;
    _data['src'] = src;
    _data['name'] = name;
    _data['alt'] = alt;
    return _data;
  }
}

class Links {
  Links({
    required this.self,
    required this.collection,
  });
  late final List<Self> self;
  late final List<Collection> collection;

  Links.fromJson(Map<String, dynamic> json) {
    self = List.from(json['self']).map((e) => Self.fromJson(e)).toList();
    collection = List.from(json['collection'])
        .map((e) => Collection.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['self'] = self.map((e) => e.toJson()).toList();
    _data['collection'] = collection.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Self {
  Self({
    required this.href,
  });
  late final String href;

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['href'] = href;
    return _data;
  }
}

class Collection {
  Collection({
    required this.href,
  });
  late final String href;

  Collection.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['href'] = href;
    return _data;
  }
}
