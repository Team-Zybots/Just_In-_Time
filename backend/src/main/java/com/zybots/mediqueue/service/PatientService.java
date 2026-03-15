package com.zybots.mediqueue.service;

import com.zybots.mediqueue.model.Patient;
import com.zybots.mediqueue.repository.PatientRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class PatientService {

    private final PatientRepository patientRepository;

    public PatientService(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    // Save a new patient to the database
    public Patient registerPatient(Patient patient) {
        return patientRepository.save(patient);
    }

    // Find a specific patient by their ID
    public Optional<Patient> getPatientById(Long id) {
        return patientRepository.findById(id);
    }
}
