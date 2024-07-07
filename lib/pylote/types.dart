class Job {
  final String url;
  final String tjm;
  final String city;
  final String date;
  final String joursSemaine;
  final String plateforme;
  final String remote;
  final String duree;
  final String dureeMois;
  final String aDistanceOuSurPlace;
  final String title;
  final String id;

  String? recruiterThumbnail; // Mobylote only

  Job({
    required this.url,
    required this.tjm,
    required this.city,
    required this.date,
    required this.joursSemaine,
    required this.plateforme,
    required this.remote,
    required this.duree,
    required this.dureeMois,
    required this.aDistanceOuSurPlace,
    required this.title,
    required this.id,
    this.recruiterThumbnail,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      url: json['URL'] ?? '',
      tjm: json['TJM'] ?? '',
      city: json['city'] ?? '',
      date: json['Date'] ?? '',
      joursSemaine: json['Jours/semaine'] ?? '',
      plateforme: json['Plateforme'] ?? '',
      remote: json['remote'] ?? '',
      duree: json['Durée'] ?? '',
      dureeMois: json['Durée_mois'] ?? '',
      aDistanceOuSurPlace: json['A distance/Sur place'] ?? '',
      title: json['Title'] ?? '',
      id: json['id'] ?? ''
    );
  }
}


class Profile {
  final Basics basics;
  final List<Education> education;
  final Meta meta;
  final List<Skill> skills;
  final List<Work> work;

  Profile({
    required this.basics,
    required this.education,
    required this.meta,
    required this.skills,
    required this.work,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      basics: Basics.fromJson(json['basics']),
      education: (json['education'] as List)
          .map((e) => Education.fromJson(e))
          .toList(),
      meta: Meta.fromJson(json['meta']),
      skills: (json['skills'] as List).map((e) => Skill.fromJson(e)).toList(),
      work: (json['work'] as List).map((e) => Work.fromJson(e)).toList(),
    );
  }
}

class Basics {
  final String image;
  final List<Language> languages;
  final Location location;
  final String name;
  final String phone;
  final List<ProfileLink> profiles;
  final String summary;

  Basics({
    required this.image,
    required this.languages,
    required this.location,
    required this.name,
    required this.phone,
    required this.profiles,
    required this.summary,
  });

  factory Basics.fromJson(Map<String, dynamic> json) {
    return Basics(
      image: json['image'],
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

  Meta({
    required this.firstName,
    required this.freelance,
    required this.lastName,
    required this.importType,
    required this.completion,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      firstName: json['firstName'],
      freelance: Freelance.fromJson(json['freelance']),
      lastName: json['lastName'],
      importType: json['importType'],
      completion: json['completion'],
    );
  }
}

class Freelance {
  final String availabilityDate;
  final bool available;
  final bool openToCdi;
  final List<String>professions;
  final Preferences preferences;
  final String seniority;
  final String rate;

  Freelance({
    required this.availabilityDate,
    required this.available,
    required this.openToCdi,
    required this.professions,
    required this.preferences,
    required this.seniority,
    required this.rate,
  });

  factory Freelance.fromJson(Map<String, dynamic> json) {
    return Freelance(
      availabilityDate: json['availabilityDate'],
      available: bool.parse(json['available']),
      openToCdi: json['openToCdi'],
      professions: List<String>.from(json['professions']),
      preferences: Preferences.fromJson(json['preferences']),
      seniority: json['seniority'],
      rate: json['rate'],
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
