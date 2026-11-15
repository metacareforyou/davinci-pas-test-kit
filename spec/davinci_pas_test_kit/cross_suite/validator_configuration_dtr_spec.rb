RSpec.describe 'PAS v2.2.1 validator configuration' do # rubocop:disable RSpec/DescribeClass
  it 'loads DTR 2.2.0, so a DTR QuestionnaireResponse in a request resolves under CRD 2.2.1' do
    expect(DaVinciPASTestKit::V221_VALIDATOR_IGS).to include('hl7.fhir.us.davinci-dtr#2.2.0')
  end

  it 'sends DTR 2.2.0 to the validator for the v2.2.1 client suite' do
    suite = Inferno::Repositories::TestSuites.new.find('davinci_pas_client_suite_v221')
    validator = suite.fhir_validators[:default].first
    expect(validator.igs).to include('hl7.fhir.us.davinci-dtr#2.2.0')
  end
end
