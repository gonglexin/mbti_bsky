defmodule MbtiBsky.MbtiData do
  @moduledoc """
  Comprehensive MBTI type data including descriptions, traits, and famous people.
  """

  @raw_mbti_types %{
    "INTJ" => %{
      name: "The Architect",
      description: "Imaginative and strategic thinkers with a plan for everything.",
      traits: [
        "Strategic and analytical",
        "Independent and decisive",
        "Organized and structured",
        "Innovative and visionary"
      ],
      strengths: [
        "Hard-working and determined",
        "Open-minded and curious",
        "Creative and imaginative",
        "Rational and logical"
      ],
      weaknesses: [
        "Arrogant and judgmental",
        "Overly analytical",
        "Dislikes rules and authority",
        "Often critical of others"
      ],
      famous_people: [
        "Elon Musk",
        "Mark Zuckerberg",
        "Isaac Newton",
        "Nikola Tesla",
        "Stephen Hawking"
      ],
      careers: ["Software Architect", "Scientist", "Engineer", "Strategic Planner", "Lawyer"],
      dimensions: %{
        "E/I" => "Introvert",
        "S/N" => "Intuitive",
        "T/F" => "Thinking",
        "J/P" => "Judging"
      }
    },
    "INTP" => %{
      name: "The Logician",
      description: "Innovative inventors with an unquenchable thirst for knowledge.",
      traits: [
        "Analytical and logical",
        "Creative and inventive",
        "Independent and autonomous",
        "Flexible and adaptable"
      ],
      strengths: [
        "Great problem solver",
        "Analytical and objective",
        "Creative and original",
        "Open-minded"
      ],
      weaknesses: [
        "Very private",
        "Insensitive to others",
        "Condescending",
        "Often dissatisfied"
      ],
      famous_people: [
        "Albert Einstein",
        "Bill Gates",
        "Socrates",
        "Charles Darwin",
        "Abraham Lincoln"
      ],
      careers: ["Software Developer", "Researcher", "Professor", "Data Analyst", "Writer"],
      dimensions: %{
        "E/I" => "Introvert",
        "S/N" => "Intuitive",
        "T/F" => "Thinking",
        "J/P" => "Perceiving"
      }
    },
    "ENTJ" => %{
      name: "The Commander",
      description: "Bold, imaginative, and strong-willed leaders, always finding a way.",
      traits: [
        "Natural leader",
        "Confident and assertive",
        "Strategic and organized",
        "Efficient and decisive"
      ],
      strengths: [
        "Excellent leadership",
        "Self-confident",
        "Strong-willed",
        "Strategic thinker"
      ],
      weaknesses: [
        "Intolerant and impatient",
        "Arrogant",
        "Cold and ruthless",
        "Poor handling of emotions"
      ],
      famous_people: [
        "Steve Jobs",
        "Margaret Thatcher",
        "Napoleon Bonaparte",
        "Winston Churchill",
        "Gordon Ramsay"
      ],
      careers: ["CEO", "Management Consultant", "Lawyer", "Politician", "Executive"],
      dimensions: %{
        "E/I" => "Extrovert",
        "S/N" => "Intuitive",
        "T/F" => "Thinking",
        "J/P" => "Judging"
      }
    },
    "ENTP" => %{
      name: "The Debater",
      description: "Smart and curious thinkers who cannot resist an intellectual challenge.",
      traits: [
        "Quick-witted and clever",
        "Resourceful and adaptable",
        "Charismatic and energetic",
        "Innovative and creative"
      ],
      strengths: [
        "Knowledgeable and curious",
        "Original thinker",
        "Excellent brainstormer",
        "Charismatic"
      ],
      weaknesses: [
        "Argumentative",
        "Insensitive",
        "Unfocused",
        "Dislikes practical matters"
      ],
      famous_people: [
        "Walt Disney",
        "Benjamin Franklin",
        "Thomas Edison",
        "Oscar Wilde",
        "Mark Twain"
      ],
      careers: ["Entrepreneur", "Consultant", "Journalist", "Sales", "Marketing"],
      dimensions: %{
        "E/I" => "Extrovert",
        "S/N" => "Intuitive",
        "T/F" => "Thinking",
        "J/P" => "Perceiving"
      }
    },
    "INFJ" => %{
      name: "The Advocate",
      description: "Quiet and mystical, yet very inspiring and tireless idealists.",
      traits: [
        "Idealistic and organized",
        "Compassionate and caring",
        "Creative and insightful",
        "Principled and decisive"
      ],
      strengths: [
        "Insightful and inspiring",
        "Principled",
        "Altruistic and creative",
        "Determined and passionate"
      ],
      weaknesses: [
        "Extremely private",
        "Perfectionist",
        "Burnout prone",
        "Sensitive to criticism"
      ],
      famous_people: [
        "Martin Luther King Jr.",
        "Mahatma Gandhi",
        "Mother Teresa",
        "Nelson Mandela",
        "Plato"
      ],
      careers: ["Counselor", "Writer", "Social Worker", "Teacher", "HR Manager"],
      dimensions: %{
        "E/I" => "Introvert",
        "S/N" => "Intuitive",
        "T/F" => "Feeling",
        "J/P" => "Judging"
      }
    },
    "INFP" => %{
      name: "The Mediator",
      description: "Poetic, kind and altruistic people, always eager to help a good cause.",
      traits: [
        "Creative and imaginative",
        "Caring and compassionate",
        "Idealistic and principled",
        "Loyal and devoted"
      ],
      strengths: [
        "Open-minded and creative",
        "Dedicated and hard-working",
        "Passionate and altruistic",
        "Artistic and expressive"
      ],
      weaknesses: [
        "Too idealistic",
        "Difficult to get to know",
        "Self-critical",
        "Impractical"
      ],
      famous_people: [
        "J.R.R. Tolkien",
        "William Shakespeare",
        "John Lennon",
        "Princess Diana",
        "Vincent van Gogh"
      ],
      careers: ["Artist", "Writer", "Counselor", "Teacher", "Psychologist"],
      dimensions: %{
        "E/I" => "Introvert",
        "S/N" => "Intuitive",
        "T/F" => "Feeling",
        "J/P" => "Perceiving"
      }
    },
    "ENFJ" => %{
      name: "The Protagonist",
      description: "Charismatic and inspiring leaders, able to mesmerize their listeners.",
      traits: [
        "Charismatic and inspiring",
        "Natural leader",
        "Altruistic and empathetic",
        "Organized and decisive"
      ],
      strengths: [
        "Charismatic",
        "Natural leader",
        "Reliable",
        "Altruistic"
      ],
      weaknesses: [
        "Too sensitive",
        "Unrealistic",
        "Too selfless",
        "Vulnerable to criticism"
      ],
      famous_people: [
        "Oprah Winfrey",
        "Barack Obama",
        "Maya Angelou",
        "Emma Watson",
        "Morgan Freeman"
      ],
      careers: ["Teacher", "HR Manager", "Politician", "Coach", "Non-profit Director"],
      dimensions: %{
        "E/I" => "Extrovert",
        "S/N" => "Intuitive",
        "T/F" => "Feeling",
        "J/P" => "Judging"
      }
    },
    "ENFP" => %{
      name: "The Campaigner",
      description:
        "Enthusiastic, creative and sociable free spirits, who can always find a reason to smile.",
      traits: [
        "Enthusiastic and energetic",
        "Creative and imaginative",
        "Sociable and friendly",
        "Excellent communicator"
      ],
      strengths: [
        "Curious",
        "Observant",
        "Excellent communication",
        "Energetic and enthusiastic"
      ],
      weaknesses: [
        "Poor practical skills",
        "Difficult to focus",
        "Easily stressed",
        "Overthinking"
      ],
      famous_people: [
        "Robin Williams",
        "Will Smith",
        "Ellen DeGeneres",
        "Quentin Tarantino",
        "Mark Wahlberg"
      ],
      careers: ["Journalist", "Actor", "Diplomat", "Event Planner", "Consultant"],
      dimensions: %{
        "E/I" => "Extrovert",
        "S/N" => "Intuitive",
        "T/F" => "Feeling",
        "J/P" => "Perceiving"
      }
    },
    "ISTJ" => %{
      name: "The Logistician",
      description: "Practical and fact-minded individuals, whose reliability cannot be doubted.",
      traits: [
        "Responsible and dependable",
        "Organized and methodical",
        "Honest and direct",
        "Traditional and dutiful"
      ],
      strengths: [
        "Honest and direct",
        "Dedicated",
        "Patient and determined",
        "Very organized"
      ],
      weaknesses: [
        "Stubborn",
        "Insensitive",
        "Judgmental",
        "Resists change"
      ],
      famous_people: [
        "George Washington",
        "Queen Elizabeth II",
        "Henry Ford",
        "J. D. Rockefeller",
        "Angela Merkel"
      ],
      careers: ["Accountant", "Auditor", "Data Analyst", "Judge", "Police Officer"],
      dimensions: %{
        "E/I" => "Introvert",
        "S/N" => "Sensing",
        "T/F" => "Thinking",
        "J/P" => "Judging"
      }
    },
    "ISFJ" => %{
      name: "The Defender",
      description: "Very dedicated and warm protectors, always ready to defend their loved ones.",
      traits: [
        "Supportive and reliable",
        "Patient and observant",
        "Practical and traditional",
        "Warm and caring"
      ],
      strengths: [
        "Excellent listener",
        "Reliable and patient",
        "Imaginative and observant",
        "Enthusiastic"
      ],
      weaknesses: [
        "Humble and shy",
        "Takes things personally",
        "Represses feelings",
        "Overloads themselves"
      ],
      famous_people: [
        "Mother Teresa",
        "Rosa Parks",
        "Taylor Swift",
        "Beyoncé",
        "Princess Grace of Monaco"
      ],
      careers: ["Nurse", "Teacher", "Social Worker", "Administrative Assistant", "Counselor"],
      dimensions: %{
        "E/I" => "Introvert",
        "S/N" => "Sensing",
        "T/F" => "Feeling",
        "J/P" => "Judging"
      }
    },
    "ESTJ" => %{
      name: "The Executive",
      description: "Excellent administrators, unsurpassed at managing things or people.",
      traits: [
        "Organized and logical",
        "Dedicated and traditional",
        "Honest and direct",
        "Responsible and dependable"
      ],
      strengths: [
        "Dedicated",
        "Strong-willed",
        "Direct and honest",
        "Loyal and patient"
      ],
      weaknesses: [
        "Stubborn",
        "Insensitive",
        "Judgmental",
        "Uncomfortable with unconventional solutions"
      ],
      famous_people: [
        "Donald Trump",
        "Hillary Clinton",
        "Lyndon B. Johnson",
        "John D. Rockefeller",
        "Sam Walton"
      ],
      careers: ["Executive", "Manager", "Police Officer", "Military Officer", "Judge"],
      dimensions: %{
        "E/I" => "Extrovert",
        "S/N" => "Sensing",
        "T/F" => "Thinking",
        "J/P" => "Judging"
      }
    },
    "ESFJ" => %{
      name: "The Consul",
      description: "Extraordinarily caring, social and popular people, always eager to help.",
      traits: [
        "Social and outgoing",
        "Organized and practical",
        "Warm and empathetic",
        "Dedicated and loyal"
      ],
      strengths: [
        "Strong practical skills",
        "Strong sense of duty",
        "Very loyal",
        "Sensitive"
      ],
      weaknesses: [
        "Worried about their social status",
        "Inflexible",
        "Vulnerable to criticism",
        "Needy of approval"
      ],
      famous_people: [
        "Taylor Swift",
        "Bill Clinton",
        "Whitney Houston",
        "Jennifer Garner",
        "Danny DeVito"
      ],
      careers: ["Teacher", "Nurse", "Sales", "Event Planner", "HR Manager"],
      dimensions: %{
        "E/I" => "Extrovert",
        "S/N" => "Sensing",
        "T/F" => "Feeling",
        "J/P" => "Judging"
      }
    },
    "ISTP" => %{
      name: "The Virtuoso",
      description: "Bold and practical experimenters, masters of all kinds of tools.",
      traits: [
        "Practical and hands-on",
        "Analytical and logical",
        "Flexible and spontaneous",
        "Calm under pressure"
      ],
      strengths: [
        "Optimistic and energetic",
        "Creative and practical",
        "Spontaneous and rational",
        "Knows how to prioritize"
      ],
      weaknesses: [
        "Private",
        "Insensitive",
        "Easily bored",
        "Risky behavior"
      ],
      famous_people: [
        "Tom Cruise",
        "Bruce Willis",
        "Clint Eastwood",
        "James Dean",
        "Bear Grylls"
      ],
      careers: ["Mechanic", "Engineer", "Pilot", "Carpenter", "Police Officer"],
      dimensions: %{
        "E/I" => "Introvert",
        "S/N" => "Sensing",
        "T/F" => "Thinking",
        "J/P" => "Perceiving"
      }
    },
    "ISFP" => %{
      name: "The Adventurer",
      description:
        "Flexible and charming artists, always ready to explore and experience something new.",
      traits: [
        "Artistic and creative",
        "Gentle and sensitive",
        "Flexible and spontaneous",
        "Appreciates beauty"
      ],
      strengths: [
        "Charming",
        "Sensitive to others",
        "Imaginative",
        "Passionate"
      ],
      weaknesses: [
        "Very sensitive",
        "Dislikes conflict",
        "Easily bored",
        "Unpredictable"
      ],
      famous_people: [
        "Michael Jackson",
        "Bob Dylan",
        "Kurt Cobain",
        "Johnny Depp",
        "Princess Diana"
      ],
      careers: ["Artist", "Designer", "Musician", "Photographer", "Therapist"],
      dimensions: %{
        "E/I" => "Introvert",
        "S/N" => "Sensing",
        "T/F" => "Feeling",
        "J/P" => "Perceiving"
      }
    },
    "ESTP" => %{
      name: "The Entrepreneur",
      description:
        "Smart, energetic and very perceptive people, who truly enjoy living on the edge.",
      traits: [
        "Bold and confident",
        "Practical and observant",
        "Energetic and spontaneous",
        "Excellent improviser"
      ],
      strengths: [
        "Bold",
        "Rational and practical",
        "Original",
        "Perceptive"
      ],
      weaknesses: [
        "Insensitive",
        "Impatient",
        "Risk-prone",
        "May miss the big picture"
      ],
      famous_people: [
        "Madonna",
        "Donald Trump",
        "Eddie Murphy",
        "Bruce Lee",
        "Steve McQueen"
      ],
      careers: ["Sales", "Entrepreneur", "Marketing", "Athlete", "Police Officer"],
      dimensions: %{
        "E/I" => "Extrovert",
        "S/N" => "Sensing",
        "T/F" => "Thinking",
        "J/P" => "Perceiving"
      }
    },
    "ESFP" => %{
      name: "The Entertainer",
      description:
        "Spontaneous, energetic and enthusiastic people. Life is never boring around them.",
      traits: [
        "Enthusiastic and fun-loving",
        "Practical and observant",
        "Excellent communicator",
        "Spontaneous and adaptable"
      ],
      strengths: [
        "Bold",
        "Original and aesthetic",
        "Showmanship",
        "Practical"
      ],
      weaknesses: [
        "Sensitive",
        "Avoids conflict",
        "Easily bored",
        "Poor long-term planner"
      ],
      famous_people: [
        "Marilyn Monroe",
        "Elvis Presley",
        "Justin Bieber",
        "Pablo Picasso",
        "Ronald Reagan"
      ],
      careers: ["Actor", "Musician", "Sales", "Event Planner", "Tour Guide"],
      dimensions: %{
        "E/I" => "Extrovert",
        "S/N" => "Sensing",
        "T/F" => "Feeling",
        "J/P" => "Perceiving"
      }
    }
  }

  # Group derived from type letters: N+T Analysts, N+F Diplomats, S+J Sentinels, S+P Explorers.
  @mbti_types (for {type, data} <- @raw_mbti_types, into: %{} do
                 {group, group_label} =
                   case type do
                     <<_, ?N, ?T, _>> -> {:analysts, "Analyst"}
                     <<_, ?N, ?F, _>> -> {:diplomats, "Diplomat"}
                     <<_, ?S, _, ?J>> -> {:sentinels, "Sentinel"}
                     <<_, ?S, _, ?P>> -> {:explorers, "Explorer"}
                   end

                 {type,
                  Map.merge(data, %{
                    group: group,
                    group_label: group_label,
                    accent_css_var: "--type-" <> String.downcase(type)
                  })}
               end)

  @doc """
  Get all MBTI type information.
  """
  def all_types, do: @mbti_types

  @doc """
  Returns the group atom (`:analysts`, `:diplomats`, `:sentinels`, `:explorers`)
  for the given type, or `nil` if unknown.
  """
  def group(type) when is_binary(type) do
    case get_type(type) do
      nil -> nil
      data -> Map.get(data, :group)
    end
  end

  @doc """
  Returns the CSS custom property name holding the accent color (e.g. `--type-intj`),
  or `nil` if the type is unknown.
  """
  def accent_var(type) when is_binary(type) do
    case get_type(type) do
      nil -> nil
      data -> Map.get(data, :accent_css_var)
    end
  end

  @doc """
  Get information for a specific MBTI type.
  """
  def get_type(type) when is_binary(type) do
    Map.get(@mbti_types, type)
  end

  @doc """
  Check if a type is valid.
  """
  def valid_type?(type) when is_binary(type) do
    Map.has_key?(@mbti_types, type)
  end
end
