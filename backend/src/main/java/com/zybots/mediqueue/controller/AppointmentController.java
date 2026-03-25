package com.zybots.mediqueue.controller;

import com.zybots.mediqueue.model.Appointment;
import com.zybots.mediqueue.model.AppointmentStatus;
import com.zybots.mediqueue.service.AppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/appointments")
public class AppointmentController {

    @Autowired
    private AppointmentService appointmentService;

    // 1. CREATE: Book an appointment using URL parameters
    // Example: POST http://localhost:8081/api/appointments/book?patientId=1&doctorId=1
    @PostMapping("/book")
    public ResponseEntity<Appointment> bookAppointment(
            @RequestParam Long patientId, 
            @RequestParam Long doctorId) {
        return ResponseEntity.ok(appointmentService.bookAppointment(patientId, doctorId));
    }

    // 2. READ: View a doctor's live queue
    // Example: GET http://localhost:8081/api/appointments/queue/1
    @GetMapping("/queue/{doctorId}")
    public ResponseEntity<List<Appointment>> getDoctorQueue(@PathVariable Long doctorId) {
        return ResponseEntity.ok(appointmentService.getDoctorQueue(doctorId));
    }

    // 3. UPDATE: Keep your existing update endpoint
    @PutMapping("/{id}/update")
    public ResponseEntity<Appointment> updateAppointment(
            @PathVariable Long id, 
            @RequestParam(required = false) AppointmentStatus status,
            @RequestParam(required = false) LocalDateTime estimatedTime) {
        try {
            return ResponseEntity.ok(appointmentService.updateAppointmentStatus(id, status, estimatedTime));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
}