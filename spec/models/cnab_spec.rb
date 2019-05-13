require 'rails_helper'

RSpec.describe Cnab, type: :model do
  fixtures :user
  it { should belong_to(:user) }
  it { should have_many(:transactions) }
  it { should have_many(:stores).through(:transactions) }

  before :all do
    @cnab = Cnab.new(user: user(:user))
  end

  describe "#report_lines" do
    it "Returns an array of lines from the report file" do
      allow(Net::HTTP).to receive(:get) { File.new("spec/mock/cnab.txt").read }
      allow(@cnab.report.attachment).to receive(:service_url) { "spec/mock/cnab.txt" }
      expect(@cnab.report_lines).to be_a(Array)
      expect(@cnab.report_lines[0]).to eq("3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO       ")
      expect(@cnab.report_lines[20]).to eq("3201903010000019200845152540736777****1313172712MARCOS PEREIRAMERCADO DA AVENIDA")
    end
  end

  describe "#proccess_transactions" do
    it "Proccesses transactions asynchronously" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        @cnab.send('proccess_transactions')
      }.to have_enqueued_job(CnabJob)
    end
    it "runs automatically after create" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        Cnab.create(user: user(:user), report: File.new("spec/mock/cnab.txt"))
      }.to have_enqueued_job(CnabJob)
    end
  end

  describe "#download_report" do
    it "Downloads content from report file" do
      allow(Net::HTTP).to receive(:get) { File.new("spec/mock/cnab.txt").read }
      allow(@cnab.report.attachment).to receive(:service_url) { "spec/mock/cnab.txt" }
      expect(@cnab.send('download_report')).to be_a(String)
      expect(@cnab.send('download_report')).to include("3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO       ")
      expect(@cnab.send('download_report')).to include("3201903010000019200845152540736777****1313172712MARCOS PEREIRAMERCADO DA AVENIDA")
    end
  end
end