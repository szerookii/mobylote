class Profile {
  final List<dynamic> awards;
  final Basics basics;
  final List<dynamic> certificates;
  final List<Education> education;
  final List<dynamic> interests;
  final Meta meta;
  final List<dynamic> projects;
  final List<Skill> skills;
  final List<Work> work;

  Profile({
    required this.awards,
    required this.basics,
    required this.certificates,
    required this.education,
    required this.interests,
    required this.meta,
    required this.projects,
    required this.skills,
    required this.work,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      awards: json['awards'],
      basics: Basics.fromJson(json['basics']),
      certificates: json['certificates'],
      education: (json['education'] as List)
          .map((e) => Education.fromJson(e))
          .toList(),
      interests: json['interests'],
      meta: Meta.fromJson(json['meta']),
      projects: json['projects'],
      skills: (json['skills'] as List).map((e) => Skill.fromJson(e)).toList(),
      work: (json['work'] as List).map((e) => Work.fromJson(e)).toList(),
    );
  }
}

class Basics {
  final String email;
  final String image;
  final String label;
  final List<Language> languages;
  final Location location;
  final String name;
  final String phone;
  final List<ProfileLink> profiles;
  final String summary;
  final String url;
  final String createdAt;

  Basics({
    required this.email,
    required this.image,
    required this.label,
    required this.languages,
    required this.location,
    required this.name,
    required this.phone,
    required this.profiles,
    required this.summary,
    required this.url,
    required this.createdAt,
  });

  factory Basics.fromJson(Map<String, dynamic> json) {
    return Basics(
      email: json['email'],
      image: json['image'],
      label: json['label'],
      languages: (json['languages'] as List)
          .map((e) => Language.fromJson(e))
          .toList(),
      location: Location.fromJson(json['location']),
      name: json['name'],
      phone: json['phone'],
      profiles: (json['profiles'] as List)
          .map((e) => ProfileLink.fromJson(e))
          .toList(),
      summary: json['summary'],
      url: json['url'],
      createdAt: json['createdAt'],
    );
  }
}

class Language {
  final String fluency;
  final String language;

  Language({required this.fluency, required this.language});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      fluency: json['fluency'],
      language: json['language'],
    );
  }
}

class Location {
  final String address;
  final String region;
  final String city;
  final String countryCode;

  Location({
    required this.address,
    required this.region,
    required this.city,
    required this.countryCode,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address: json['address'],
      region: json['region'],
      city: json['city'],
      countryCode: json['countryCode'],
    );
  }
}

class ProfileLink {
  final String url;
  final String network;
  final String username;

  ProfileLink({
    required this.url,
    required this.network,
    required this.username,
  });

  factory ProfileLink.fromJson(Map<String, dynamic> json) {
    return ProfileLink(
      url: json['url'],
      network: json['network'],
      username: json['username'],
    );
  }
}

class Education {
  final String area;
  final String institution;
  final String score;
  final List<dynamic> courses;
  final String endDate;
  final String studyType;
  final String startDate;

  Education({
    required this.area,
    required this.institution,
    required this.score,
    required this.courses,
    required this.endDate,
    required this.studyType,
    required this.startDate,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      area: json['area'],
      institution: json['institution'],
      score: json['score'],
      courses: json['courses'],
      endDate: json['endDate'],
      studyType: json['studyType'],
      startDate: json['startDate'],
    );
  }
}

class Meta {
  final String firstName;
  final Freelance freelance;
  final String lastName;
  final String importType;
  final bool completion;
  final bool tutoProfileShared;
  final bool tutoProfileSync;

  Meta({
    required this.firstName,
    required this.freelance,
    required this.lastName,
    required this.importType,
    required this.completion,
    required this.tutoProfileShared,
    required this.tutoProfileSync,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      firstName: json['firstName'],
      freelance: Freelance.fromJson(json['freelance']),
      lastName: json['lastName'],
      importType: json['importType'],
      completion: json['completion'],
      tutoProfileShared: json['tuto_profileShared'],
      tutoProfileSync: json['tuto_profileSync'],
    );
  }
}

class Freelance {
  final String availabilityDate;
  final bool available;
  final bool openToCdi;
  final Preferences preferences;
  final List<String> professions;
  final String rate;
  final String seniority;
  final bool vehicle;

  Freelance({
    required this.availabilityDate,
    required this.available,
    required this.openToCdi,
    required this.preferences,
    required this.professions,
    required this.rate,
    required this.seniority,
    required this.vehicle,
  });

  factory Freelance.fromJson(Map<String, dynamic> json) {
    return Freelance(
      availabilityDate: json['availabilityDate'],
      available: bool.parse(json['available']),
      openToCdi: json['openToCdi'],
      preferences: Preferences.fromJson(json['preferences']),
      professions: List<String>.from(json['professions']),
      rate: json['rate'],
      seniority: json['seniority'],
      vehicle: json['vehicle'],
    );
  }
}

class Preferences {
  final String daysPerWeek;
  final String missionDuration;
  final List<Mobility> mobility;
  final List<String> remoteWork;
  final List<String> workAreas;
  final LocationDescription location;

  Preferences({
    required this.daysPerWeek,
    required this.missionDuration,
    required this.mobility,
    required this.remoteWork,
    required this.workAreas,
    required this.location,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      daysPerWeek: json['daysPerWeek'],
      missionDuration: json['missionDuration'],
      mobility: (json['mobility'] as List)
          .map((e) => Mobility.fromJson(e))
          .toList(),
      remoteWork: List<String>.from(json['remoteWork']),
      workAreas: List<String>.from(json['workAreas']),
      location: LocationDescription.fromJson(json['location']),
    );
  }
}

class Mobility {
  final String type;
  final String code;
  final String label;

  Mobility({
    required this.type,
    required this.code,
    required this.label,
  });

  factory Mobility.fromJson(Map<String, dynamic> json) {
    return Mobility(
      type: json['type'],
      code: json['code'],
      label: json['label'],
    );
  }
}

class LocationDescription {
  final String description;
  final String id;

  LocationDescription({
    required this.description,
    required this.id,
  });

  factory LocationDescription.fromJson(Map<String, dynamic> json) {
    return LocationDescription(
      description: json['description'],
      id: json['id'],
    );
  }
}

class Skill {
  final String level;
  final String name;
  final List<dynamic> keywords;

  Skill({
    required this.level,
    required this.name,
    required this.keywords,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      level: json['level'],
      name: json['name'],
      keywords: json['keywords'],
    );
  }
}

class Work {
  final String? summary;
  final List<dynamic> highlights;
  final String endDate;
  final String name;
  final String? location;
  final String position;
  final String startDate;
  final String url;

  Work({
    this.summary,
    required this.highlights,
    required this.endDate,
    required this.name,
    this.location,
    required this.position,
    required this.startDate,
    required this.url,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      summary: json['summary'],
      highlights: json['highlights'],
      endDate: json['endDate'],
      name: json['name'],
      location: json['location'],
      position: json['position'],
      startDate: json['startDate'],
      url: json['url'],
    );
  }
}
