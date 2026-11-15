module DaVinciPASTestKit
  # Shared FHIR resource validator configuration for the PAS suites.

  # IGs loaded by the validators in each version's suites.
  V201_VALIDATOR_IGS = ['hl7.fhir.us.davinci-pas#2.0.1'].freeze
  # DTR 2.2.0 is loaded so that a PAS request's DTR QuestionnaireResponse (dtr-questionnaireresponse|2.2.0, which
  # binds intendedUse to CRD DocReason|2.2.1) resolves under the same CRD version PAS 2.2.1 uses. Without it the
  # validator bound intendedUse to DocReason|2.1.0 but resolved its code system under CRD 2.2.1, so no coding passed.
  V221_VALIDATOR_IGS = ['hl7.fhir.us.davinci-pas#2.2.1', 'hl7.fhir.us.core#6.1.0', 'hl7.fhir.us.davinci-dtr#2.2.0'].freeze

  # The validator for resources Inferno sends to the system under test, which may be tester-provided.
  # It doesn't allow extensions beyond those defined in the IGs it loads, so that the system under
  # test drives its behavior only from standard information. Currently defined by the client suites.
  # Bundles should be validated with it using PasBundleValidation#perform_no_custom_extensions_validation.
  NO_CUSTOM_EXTENSIONS_VALIDATOR = :no_custom_extensions

  # SNOMED CT US Edition, used by the validators for SNOMED CT code validation.
  SNOMED_CT_US_EDITION = '731000124108'.freeze
end
