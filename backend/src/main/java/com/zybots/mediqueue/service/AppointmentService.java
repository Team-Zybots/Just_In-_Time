package com.zybots.mediqueue.service;

import com.zybots.mediqueue.model.Appointment;
import com.zybots.mediqueue.model.AppointmentStatus;
import com.zybots.mediqueue.model.Doctor;
import com.zybots.mediqueue.model.Patient;
import com.zybots.mediqueue.repository.AppointmentRepository;
import com.zybots.mediqueue.repository.DoctorRepository;
import com.zybots.mediqueue.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class AppointmentService {

    @Autowired
    private AppointmentRepository appointmentRepository;
    
    @Autowired
    private PatientRepository patientRepository;
    
    @Autowired
    private DoctorRepository doctorRepository;

    // 1. CREATE: Book a new appointment and auto-generate the token number
    public Appointment bookAppointment(Long patientId, Long doctorId) {
        // Fetch the actual Patient and Doctor from the database
        Patient patient = patientRepository.findById(patientId)
                .orElseThrow(() -> new RuntimeException("Patient not found!"));
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found!"));

        Appointment appointment = new Appointment();
        appointment.setPatient(patient);
        appointment.setDoctor(doctor);
        appointment.setStatus(AppointmentStatus.PENDING);
        appointment.setEstimatedTime(LocalDateTime.now().plusMinutes(30)); // Mock wait time

        // THE MAGIC QUEUE LOGIC: Count how many people are already in the doctor's queue to get the next token!
        List<Appointment> currentQueue = appointmentRepository.findByDoctorIdOrderByTokenNumberAsc(doctorId);
        int nextTokenNumber = currentQueue.size() + 1;
        appointment.setTokenNumber(nextTokenNumber);

        return appointmentRepository.save(appointment);
    }

    // 2. READ: Get the live queue for a specific doctor (using your custom method!)
    public List<Appointment> getDoctorQueue(Long doctorId) {
        return appointmentRepository.findByDoctorIdOrderByTokenNumberAsc(doctorId);
    }

    // (Keep your existing updateAppointmentStatus method here!)
    public Appointment updateAppointmentStatus(Long id, AppointmentStatus newStatus, LocalDateTime newTime) {
        return appointmentRepository.findById(id).map(existing -> {
            if (newStatus != null) existing.setStatus(newStatus);
            if (newTime != null) existing.setEstimatedTime(newTime);
            return appointmentRepository.save(existing);
        }).orElseThrow(() -> new RuntimeException("Appointment not found!"));
    }
}