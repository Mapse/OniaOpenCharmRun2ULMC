// -*- C++ -*-
//
// Package:    GenAnalyzer/GenParticleAnalyzer
// Class:      GenParticleAnalyzer
//
/**\class GenParticleAnalyzer GenParticleAnalyzer.cc GenAnalyzer/GenParticleAnalyzer/plugins/GenParticleAnalyzer.cc

 Description: Very simple analyzer for get b, c quarks, D0, D+, D*, Upsilon, Jpsi and muons parameters
              from GS step to NanoAODlike NTuple.

 Implementation:
     [Notes on implementation]
*/
//
// Original Author:  Kevin Mota Amarilo
//         Created:  Fri, 10 Jul 2020 09:26:44 GMT
//
//


// system include files
#include <memory>
#include <string>
#include <iostream>
#include <sstream>
#include <vector>

// user include files
#include "FWCore/Framework/interface/Frameworkfwd.h"
#include "FWCore/Framework/interface/one/EDAnalyzer.h"
#include "FWCore/Framework/interface/ESHandle.h"

#include "FWCore/Framework/interface/Event.h"
#include "FWCore/Framework/interface/EventSetup.h"
#include "FWCore/Framework/interface/MakerMacros.h"

#include "FWCore/ParameterSet/interface/ParameterSet.h"
#include "FWCore/Utilities/interface/InputTag.h"

#include "SimGeneral/HepPDTRecord/interface/ParticleDataTable.h"
#include "DataFormats/Candidate/interface/Candidate.h"
#include "DataFormats/Candidate/interface/CandidateFwd.h"
#include "DataFormats/HepMCCandidate/interface/GenParticle.h"
#include "DataFormats/Common/interface/Ref.h"

// For Root
#include "CommonTools/UtilAlgos/interface/TFileService.h"
#include "FWCore/ServiceRegistry/interface/Service.h"
#include "TTree.h"
#include "TH1.h"
#include "TH3.h"

//
// class declaration
//

// If the analyzer does not use TFileService, please remove
// the template argument to the base class so the class inherits
// from  edm::one::EDAnalyzer<>
// This will improve performance in multithreaded jobs.

class GenParticleAnalyzer : public edm::one::EDAnalyzer<edm::one::SharedResources>  {
   public:
      explicit GenParticleAnalyzer(const edm::ParameterSet&);
      ~GenParticleAnalyzer();

      static void fillDescriptions(edm::ConfigurationDescriptions& descriptions);


   private:
      virtual void beginJob() override;
      virtual void analyze(const edm::Event&, const edm::EventSetup&) override;
      virtual void endJob() override;
      void initialize();

      // ----------member data ---------------------------
      edm::EDGetTokenT<reco::GenParticleCollection> genTkn;  //Select genParticle colection

      TTree *Events;
      TFile *file;

      // Store for genParticles the important variables.
      
      UInt_t nGenPart;
      std::vector<Int_t> GenPart_pdgId;
      std::vector<Float_t> GenPart_pt;
      std::vector<Float_t> GenPart_eta;
      std::vector<Float_t> GenPart_phi;
      std::vector<Float_t> GenPart_mass;
      std::vector<Float_t> GenPart_charge;
      std::vector<Float_t> GenPart_vx;
      std::vector<Float_t> GenPart_vy;
      std::vector<Float_t> GenPart_vz;
      std::vector<Float_t> GenPart_ndaughters;

      // Store Mother vtx and pdgId
      std::vector<Int_t> GenPart_mpdgId;
      std::vector<Float_t> GenPart_mvx;
      std::vector<Float_t> GenPart_mvy;
      std::vector<Float_t> GenPart_mvz;

      // PV position
      Float_t GenPart_PVx;
      Float_t GenPart_PVy;
      Float_t GenPart_PVz;

      // description
      std::string outFile;

      int _verbose;
};

//
// constants, enums and typedefs
//

const unsigned nReserve_GenPart = 1024;

//
// static data member definitions
//

//
// constructors and destructor
//
GenParticleAnalyzer::GenParticleAnalyzer(const edm::ParameterSet& iConfig)
{
   //now do what ever initialization is needed
   /* edm::Service<TFileService> fs; */
   outFile = iConfig.getParameter<std::string>("outFile");
   _verbose = iConfig.getParameter<int>("verbose");
   file = new TFile(outFile.c_str(), "recreate"); // check
   Events = new TTree("Events", "Events");
   //Events = fs->make<TTree>("Events","Events");

   genTkn = consumes<reco::GenParticleCollection>(edm::InputTag("genParticles"));

}


GenParticleAnalyzer::~GenParticleAnalyzer()
{
   // do anything here that needs to be done at desctruction time
   // (e.g. close files, deallocate resources etc.)
   file->Close();
   delete Events;
   delete file;
}


//
// member functions
//

// ------------ method called for each event  ------------
void GenParticleAnalyzer::analyze(const edm::Event& iEvent, const edm::EventSetup& iSetup)
{
   using namespace edm;

   edm::Handle<reco::GenParticleCollection> genParticles;
   iEvent.getByToken(genTkn, genParticles);

   initialize();

   bool PVfilled = false;
   for (auto genp = genParticles->begin(); genp < genParticles->end(); ++genp) {
      
      // Store PV position
      if (!PVfilled && genp->vz() != 0){
        GenPart_PVx = genp->vx();
        GenPart_PVy = genp->vy();
        GenPart_PVz = genp->vz();
        PVfilled = true;
      }
      

      // Get the b and c quarks, D0, D+, D_s+, D*, Lambda_c+, Upsilon, Jpsi, protons, Kaons, pions and muons
      if ( (std::abs(genp->pdgId()) == 5) || (std::abs(genp->pdgId()) == 4) || (std::abs(genp->pdgId()) == 421) || 
            (std::abs(genp->pdgId()) == 413) || (std::abs(genp->pdgId()) == 411) || (std::abs(genp->pdgId()) == 443) || 
            (std::abs(genp->pdgId()) == 553) || (std::abs(genp->pdgId()) == 13) || (std::abs(genp->pdgId()) == 211) || 
            (std::abs(genp->pdgId()) == 321) || (std::abs(genp->pdgId()) == 431) || (std::abs(genp->pdgId()) == 2112)) {
         
         // Remove beams protons, because they don't have mother.
         if ((std::abs(genp->pdgId()) == 2112) && genp->status() == 4 ) continue;
         
         const reco::Candidate *mom = genp->mother(); 

         /* bool oniaMom = (std::abs(mom->pdgId()) == 553) || (std::abs(mom->pdgId()) == 443);
         bool Dmom = (std::abs(mom->pdgId()) == 411) || (std::abs(mom->pdgId()) == 413) || (std::abs(mom->pdgId()) == 421) || (std::abs(mom->pdgId()) == 443);
         bool track = (std::abs(genp->pdgId()) == 211) || (std::abs(genp->pdgId()) == 321); */

         /* if ((std::abs(genp->pdgId()) == 13) && !oniaMom) continue;
         if (track && !Dmom) continue;
 */
          if ((_verbose > 0) && (std::abs(genp->pdgId()) == 553)) {
            std::cout << "Found upsilon. " << "vtx: x=" << genp->vx() << " y=" << genp->vy() << " z=" << genp->vz() << " status="  << genp->status() << std::endl;
            std::cout << "n daughter: " << genp->numberOfDaughters() << std::endl;
            size_t ndau = genp->numberOfDaughters();
            for (size_t i = 0; i < ndau; ++i) {
               const reco::Candidate *daughter = genp->daughter(i);
               std::cout << (daughter->pdgId()) << std::endl;
            }            
         } 

         if (GenPart_pdgId.size() < nReserve_GenPart){
            GenPart_pdgId.push_back(genp->pdgId());
            GenPart_pt.push_back(genp->pt());
            GenPart_eta.push_back(genp->eta());
            GenPart_phi.push_back(genp->phi());
            GenPart_mass.push_back(genp->mass());
            GenPart_charge.push_back(genp->charge());
            GenPart_vx.push_back(genp->vx());
            GenPart_vy.push_back(genp->vy());
            GenPart_vz.push_back(genp->vz());
            GenPart_ndaughters.push_back(genp->numberOfDaughters());

            GenPart_mpdgId.push_back(mom->pdgId());
            GenPart_mvx.push_back(mom->vx());
            GenPart_mvy.push_back(mom->vy());
            GenPart_mvz.push_back(mom->vz());
         }
         else{
            std::cout << "N of GenPart is greater than your reserve" << std::endl;
         }
      }

   }

   nGenPart = GenPart_pt.size();
   Events->Fill();
}

// Clear the vectors and initialize variables
void GenParticleAnalyzer::initialize() {
   GenPart_PVx = -999.;
   GenPart_PVy = -999.;
   GenPart_PVz = -999.;

   GenPart_pdgId.clear();
   GenPart_pt.clear();
   GenPart_eta.clear();
   GenPart_phi.clear();
   GenPart_mass.clear();
   GenPart_charge.clear();
   GenPart_vx.clear();
   GenPart_vy.clear();
   GenPart_vz.clear();
   GenPart_ndaughters.clear();

   GenPart_mpdgId.clear();
   GenPart_mvx.clear();
   GenPart_mvy.clear();
   GenPart_mvz.clear();
}


// ------------ method called once each job just before starting event loop  ------------
void GenParticleAnalyzer::beginJob()
{
   GenPart_pdgId.reserve(nReserve_GenPart);
   GenPart_pt.reserve(nReserve_GenPart);
   GenPart_eta.reserve(nReserve_GenPart);
   GenPart_phi.reserve(nReserve_GenPart);
   GenPart_mass.reserve(nReserve_GenPart);
   GenPart_charge.reserve(nReserve_GenPart);
   GenPart_vx.reserve(nReserve_GenPart);
   GenPart_vy.reserve(nReserve_GenPart);
   GenPart_vz.reserve(nReserve_GenPart);
   GenPart_ndaughters.reserve(nReserve_GenPart);

   GenPart_mpdgId.reserve(nReserve_GenPart);
   GenPart_mvx.reserve(nReserve_GenPart);
   GenPart_mvy.reserve(nReserve_GenPart);
   GenPart_mvz.reserve(nReserve_GenPart);

   Events->Branch("nGenPart", &nGenPart, "nGenPart/I");
   Events->Branch("GenPart_pt", GenPart_pt.data(), "GenPart_pt[nGenPart]/F");
   Events->Branch("GenPart_eta", GenPart_eta.data(), "GenPart_eta[nGenPart]/F");
   Events->Branch("GenPart_phi", GenPart_phi.data(), "GenPart_phi[nGenPart]/F");
   Events->Branch("GenPart_mass", GenPart_mass.data(), "GenPart_mass[nGenPart]/F");
   Events->Branch("GenPart_charge", GenPart_charge.data(), "GenPart_charge[nGenPart]/F");
   Events->Branch("GenPart_pdgId", GenPart_pdgId.data(), "GenPart_pdgId[nGenPart]/I");
   Events->Branch("GenPart_vx", GenPart_vx.data(), "GenPart_vx[nGenPart]/F");
   Events->Branch("GenPart_vy", GenPart_vy.data(), "GenPart_vy[nGenPart]/F");
   Events->Branch("GenPart_vz", GenPart_vz.data(), "GenPart_vz[nGenPart]/F");
   Events->Branch("GenPart_ndaughters", GenPart_ndaughters.data(), "GenPart_ndaughters[nGenPart]/I");

   Events->Branch("GenPart_mvx", GenPart_mvx.data(), "GenPart_mvx[nGenPart]/F");
   Events->Branch("GenPart_mvy", GenPart_mvy.data(), "GenPart_mvy[nGenPart]/F");
   Events->Branch("GenPart_mvz", GenPart_mvz.data(), "GenPart_mvz[nGenPart]/F");
   Events->Branch("GenPart_mpdgId", GenPart_mpdgId.data(), "GenPart_mpdgId[nGenPart]/I");

   Events->Branch("GenPart_PVx", &GenPart_PVx, "GenPart_PVx/F");
   Events->Branch("GenPart_PVy", &GenPart_PVy, "GenPart_PVy/F");
   Events->Branch("GenPart_PVz", &GenPart_PVz, "GenPart_PVz/F");
}

// ------------ method called once each job just after ending the event loop  ------------
void GenParticleAnalyzer::endJob()
{
   Events->Write();
}

// ------------ method fills 'descriptions' with the allowed parameters for the module  ------------
void GenParticleAnalyzer::fillDescriptions(edm::ConfigurationDescriptions& descriptions) {
  //The following says we do not know what parameters are allowed so do no validation
  // Please change this to state exactly what you do use, even if it is no parameters
   edm::ParameterSetDescription desc;
   desc.add<std::string>("outFile", "test.root");
   desc.add<int>("verbose", 0);
   descriptions.add("GenParticleAnalyzer", desc);

}

//define this as a plug-in
DEFINE_FWK_MODULE(GenParticleAnalyzer);
