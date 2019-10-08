# frozen_string_literal: true

module ClimateProjectService
  module_function

  PROJECTS = [
    {
      name: 'electricitymap-contrib',
      url: 'https://github.com/tmrowco/electricitymap-contrib',
      language: 'Python',
      description: 'A real-time visualisation of the CO2 emissions of electricity consumption'
    },
    {
      name: 'tmrowapp-contrib',
      url: 'https://github.com/tmrowco/tmrowapp-contrib',
      language: 'JavaScript',
      description: 'Tomorrow automatically calculates the climate impact of your daily choices by connecting to apps and services you already use.'
    },
    {
      name: 'community-toolbox',
      url: 'https://github.com/publiclab/community-toolbox',
      language: 'JavaScript',
      description: 'Tools to understand and welcome people into a contributor community'
    },
    {
      name: 'polarmap.js',
      url: 'https://github.com/GeoSensorWebLab/polarmap.js',
      language: 'JavaScript',
      description: 'Custom Leaflet layer for re-projecting maps and map features'
    },
    {
      name: 'climate',
      url: 'https://github.com/apache/climate',
      language: 'Jupyter Notebook',
      description: 'Mirror of Apache Open Climate Workbench'
    },
    {
      name: 'awesome-open-climate-science',
      url: 'https://github.com/pangeo-data/awesome-open-climate-science',
      language: nil,
      description: 'Awesome Open Atmospheric, Ocean, and Climate Science'
    },
    {
      name: 'contributor_covenant',
      url: 'https://github.com/Ecohackerfarm/contributor_covenant',
      language: 'CSS',
      description: 'Pledge your respect and appreciation for contributors of all kinds to your open source project.'
    },
    {
      name: 'RebelsManager',
      url: 'https://github.com/extinctionrebellion/',
      language: 'Ruby',
      description: 'Extinction Rebellion is an international movement that uses non-violent civil disobedience in an attempt to halt mass extinction and minimise the risk of social collapse. The Rebels Manager is a CRM app for coordinators.'
    },
    {
      name: 'pangeo',
      url: 'https://github.com/pangeo-data/pangeo',
      language: 'Jupyter Notebook',
      description: 'Pangeo website + discussion of general issues related to the project.'
    }
  ].freeze

  def sample(sample_size = 1)
    projects = PROJECTS.shuffle
    projects.first(sample_size)
  end
end
