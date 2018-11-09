#include "mp_scheduler.h"
#include <iostream>

MP_Scheduler::MP_Scheduler(schedule algo) {
  m_algo = algo;
}

bool MP_Scheduler::has_ready_threads() {
  if( m_ready_queue.empty() ) {
    return false;
  }

  return true;
}

MP_Thread* MP_Scheduler::get_next_thread() {
  MP_Thread* next_thread = NULL;

  if( has_ready_threads() ) {
    if( m_algo == FCFS || m_algo == ROUND_ROBIN || m_algo == RERUN_FCFS || m_algo == RERUN_ROUND_ROBIN) {
      next_thread = m_ready_queue.front();
      m_ready_queue.pop();
    }
  }

  return next_thread;
}

bool MP_Scheduler::needs_quantum() {
 if( m_algo == ROUND_ROBIN || m_algo == RERUN_ROUND_ROBIN) {
   return true;
 }

 return false;
}

void MP_Scheduler::add_ready(MP_Thread *thread)
{
  m_ready_queue.push(thread);
}

MP_Scheduler::schedule MP_Scheduler::get_schedule_algo()
{
	return m_algo;
}

void MP_Scheduler::clear_ready()
{
	while(!m_ready_queue.empty())
	{
		m_ready_queue.pop();
	}
}
