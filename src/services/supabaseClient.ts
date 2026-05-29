import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || 'https://iudghjdmfcxjcpspeify.supabase.co';
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1ZGdoamRtZmN4amNwc3BlaWZ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM0MTUxNTcsImV4cCI6MjA0ODk5NTE1N30.0I1cz5l8fPNuWb6fA1B2C3D4E5F6G7H8I9J0K1L2M3';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
