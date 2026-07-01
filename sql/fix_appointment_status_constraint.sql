-- fix_appointment_status_constraint.sql
-- O constraint original não incluía 'in_progress' e 'rescheduled'.
-- Execute no Supabase SQL Editor.

ALTER TABLE appointments DROP CONSTRAINT IF EXISTS appointments_status_check;

ALTER TABLE appointments
  ADD CONSTRAINT appointments_status_check
  CHECK (status IN ('scheduled', 'confirmed', 'in_progress', 'completed', 'cancelled', 'rescheduled', 'no_show'));
