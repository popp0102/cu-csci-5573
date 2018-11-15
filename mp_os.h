//
//  Header.h
//  mp_memory
//
//  Created by Natalie Plotkin on 11/14/18.
//  Copyright © 2018 Natalie Plotkin. All rights reserved.
//

#ifndef MP_OS_H
#define MP_OS_H

#include <queue>
#include <sys/time.h>
#include<exception>
#include "mp_scheduler.h"
#include "mp_dispatcher.h"
#include "mp_thread.h"
#include "mp_logger.h"
#include <string>
#include "memorydumper.h"
#include "mpStackTrace.h"
#include <sstream>
#include <fstream>
class MP_OS {
public:
    MP_OS(MP_Scheduler::schedule, int, std::string);
    
    void thread_create(void (*start_routine)(), std::string label);
    void wait();
    
private:
    MP_Logger *mp_logger;
    MP_Dispatcher *m_dispatcher;
    MP_Scheduler *m_scheduler;
    MP_Thread *m_os_thread;
    mp_MemMan *mp_memman;
    int m_quantum;
    bool m_quantum_exp;
    struct itimerval m_quantum_timer;
    std::queue<MP_Thread*> m_user_threads;
    std::string fileNameBackup;
    void setup_interrupt_handler();
    void start_quantum_timer();
    void stop_quantum_timer();
    void set_quantum_timer(int);
    void quantum_expired();
    void handle_finished_threads();
    void LogStackTrace();
    void PrepareRecoveryFromSegFault();
    void ReSchedule();
    void * mp_malloc(numbytes);
    
    static MP_OS* os;
    static void interrupt_handler(int i);
};

#endif