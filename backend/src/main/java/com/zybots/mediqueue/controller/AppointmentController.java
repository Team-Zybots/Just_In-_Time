package com.zybots.mediqueue.controller;

import com.zybots.mediqueue.model.Appointment;
import com.zybots.mediqueue.service.AppointmentService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/appointments")
public class AppointmentController {

    private final AppointmentService appointmentService;

    public AppointmentController(AppointmentService appointmentService) {
        this.appointmentService = appointmentService;
    }

    // Flutter sends the booking details here
    @PostMapping("/book")
    public Appointment bookAppointment(@RequestBody Appointment appointment) {
        return appointmentService.bookAppointment(appointment);
    }

    // Flutter calls this to display the Live Queue on the screen
    @GetMapping("/queue/{doctorId}")
    public List<Appointment> getDoctorQueue(@PathVariable Long doctorId) {
        return appointmentService.getQueueForDoctor(doctorId);
    }
}