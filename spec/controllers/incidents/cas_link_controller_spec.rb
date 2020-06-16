require 'spec_helper'

describe Incidents::CasLinkController, :type => :controller do
  include LoggedIn
  before(:each) { grant_role! 'cas_admin' }
  render_views

  it "displays the list" do
    cas = FactoryGirl.create :cas_incident, chapter: @person.chapter, county_name: @person.counties.first.name
    cas2 = FactoryGirl.create :cas_incident, chapter: @person.chapter
    inc = FactoryGirl.create :incident, chapter: @person.chapter
    inc2 = FactoryGirl.create :incident, chapter: @person.chapter

    inc.link_to_cas_incident(cas2)

    get :index, params: { chapter_id: inc.chapter.to_param }

    expect(response).to be_success
    expect(controller.send(:collection)).to match_array([cas])
  end

  it "can link an incident" do
    cas = FactoryGirl.create :cas_incident, chapter: @person.chapter
    inc = FactoryGirl.create :incident, chapter: @person.chapter

    post :link, params: { id: cas.to_param, incident_id: inc.id, chapter_id: inc.chapter.to_param }
    expect(response).to be_redirect
    expect(flash[:info]).not_to be_empty

    expect(inc.reload.cas_event_number).to eq(cas.cas_incident_number)
  end

  it "won't link if the cas is already linked" do
    cas2 = FactoryGirl.create :cas_incident, chapter: @person.chapter
    inc = FactoryGirl.create :incident, chapter: @person.chapter
    inc2 = FactoryGirl.create :incident, chapter: @person.chapter

    inc.link_to_cas_incident(cas2)
    expect {
      post :link, params: { id: cas2.to_param, incident_id: inc2.id, chapter_id: inc.chapter.to_param }
      expect(response).to be_redirect
      expect(flash[:error]).not_to be_empty
    }.to_not change{inc.reload.cas_event_number}
  end

  it "can ignore an incident" do
    cas = FactoryGirl.create :cas_incident, chapter: @person.chapter

    expect {
      post :ignore, params: { id: cas.to_param, chapter_id: @person.chapter.to_param }
    }.to change{cas.reload.ignore_incident}.to(true)

    expect(response).to be_redirect
    expect(flash[:info]).not_to be_empty
  end

  it "can promote to an incident" do
    cas = FactoryGirl.create :cas_incident, chapter: @person.chapter
    FactoryGirl.create :county, name: cas.county_name, chapter: @person.chapter

    expect(Geokit::Geocoders::GoogleGeocoder).to receive(:geocode).and_return(
      double lat: Faker::Address.latitude, lng: Faker::Address.longitude, success?: true, 
             city: Faker::Address.city, district: Faker::Address.city, zip: Faker::Address.zip_code, state: Faker::Address.state)

    expect {
      post :promote, params: { id: cas.to_param, commit: 'Promote to Incident', chapter_id: cas.chapter.to_param }
      expect(response).to be_redirect
      expect(flash[:info]).not_to be_empty

    }.to change(Incidents::Incident, :count).by(1)

    expect(Incidents::Incident.where(cas_event_number: cas.cas_incident_number).first).not_to be_nil
  end

end