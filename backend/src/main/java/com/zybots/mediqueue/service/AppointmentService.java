package com.zybots.mediqueue.service;

import com.zybots.mediqueue.model.Appointment;
import com.zybots.mediqueue.repository.AppointmentRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AppointmentService {

    private final AppointmentRepository appointmentRepository;

    public AppointmentService(AppointmentRepository appointmentRepository) {
        this.appointmentRepository = appointmentRepository;
    }

    // Create a new booking
    public Appointment bookAppointment(Appointment appointment) {
        // TODO: Later, we will call QueueManager here to calculate the 'estimatedTime' before saving!
        return appointmentRepository.save(appointment);
    }

    // Get the live queue for a specific doctor (ordered by token number)
    public List<Appointment> getQueueForDoctor(Long doctorId) {
        return appointmentRepository.findByDoctorIdOrderByTokenNumberAsc(doctorId);
    }
}