/*
 * Copyright (c) 2011-2012, simon listens <office@simon-listens.org>
 * Copyright (c) 2011-2012, Scuola Superiore Sant´Anna <urp@sssup.it>
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *  * Redistributions of source code must retain the above copyright
 *  notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *  * Neither the name of the organizations nor the
 *  names of its contributors may be used to endorse or promote products
 *  derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ''AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include "navigator.h"
#include <QObject>

#include <MetraLabsBase.h>

#include <config/MLRobotic_config.h>

#include <base/Application.h>
#include <robot/Robot.h>
#include <KDebug>
#include <KAboutData>
#include <QCoreApplication>

using namespace MetraLabs::base;
using namespace MetraLabs::robotic::base;
using namespace MetraLabs::robotic::robot;

///////////////////////////////////////////////////////////////////////////////

class BatteryStateCallbackHandler :
    public BlackboardDataUpdateCallback
{
    // Implementation of BlackboardDataUpdateCallback
    void dataChanged(const BlackboardData* pData);
};

void BatteryStateCallbackHandler::dataChanged(const BlackboardData* pData)
{
    //fprintf(stderr, "BatteryCallbackHandler::dataChanged\n");

    const BlackboardDataBatteryState* tBatteryState = 
	dynamic_cast<const BlackboardDataBatteryState*>(pData);
    if (tBatteryState != NULL) {
	//fprintf(stderr, "  Volt=%0.2fV, Status=0x%04x\n",
		//tBatteryState->getVoltage(),
		//tBatteryState->getChargerStatus());
    }
}

///////////////////////////////////////////////////////////////////////////////

class OdometryCallbackHandler :
    public BlackboardDataUpdateCallback
{
    // Implementation of BlackboardDataUpdateCallback
    void dataChanged(const BlackboardData* pData);
};

void OdometryCallbackHandler::dataChanged(const BlackboardData* pData)
{
    //fprintf(stderr, "OdometryCallbackHandler::dataChanged\n");

    const BlackboardDataOdometry* tOdometryData = 
	dynamic_cast<const BlackboardDataOdometry*>(pData);
    if (tOdometryData != NULL) {
	MTime tTime;
	Pose tPose;
	Velocity tVelocity;
	float tMileage;

	tOdometryData->getData(tPose, tVelocity, tMileage);
	//fprintf(stderr, "  x=%0.2f m, y=%0.2f m, phi=%0.2f deg, "
		//"v_trans=%0.2f m/s, v_rot=%0.2f deg/s\n",
		//tPose.getX(), tPose.getY(), 180.0*tPose.getPhi()/M_PI,
		//tVelocity.getVelocityTranslational(),
		//180.0*tVelocity.getVelocityRotational()/M_PI);
    }
}

///////////////////////////////////////////////////////////////////////////////

class SonarCallbackHandler :
    public BlackboardDataUpdateCallback
{
    // Implementation of BlackboardDataUpdateCallback
    void dataChanged(const BlackboardData* pData);
};

void SonarCallbackHandler::dataChanged(const BlackboardData* pData)
{
    //fprintf(stderr, "SonarCallbackHandler::dataChanged\n");

    const BlackboardDataRange* tRangeData = 
	dynamic_cast<const BlackboardDataRange*>(pData);
    if (tRangeData != NULL) {
	RangeData::Vector tRange = tRangeData->getRangeData();

	//fprintf(stderr, "  {");
	//for(unsigned int i = 0; i < tRange.size(); i++)
	    //fprintf(stderr, "(%i,%0.2f,%i) ", i, tRange[i].range, tRange[i].error);
	//fprintf(stderr, "}\n");
    }
}

///////////////////////////////////////////////////////////////////////////////

int main(int pArgc, char* pArgv[])
{
    Error tErr;

    ///////////////////////////////////////////////////////////////////////////
    // Initialization

    // Create a general application object. This will also initialize
    // the library MetraLabsBase with the command line arguments.
    Application* tApp = new Application(pArgc, pArgv);
    if (tApp == NULL) {
	fprintf(stderr, "FATAL: Can't create the application!\n");
	exit(-1);
    }
    
    // Get the class factory from the application.
    ClassFactory* tClassFactory = tApp->getClassFactory();
    if (tClassFactory == NULL) {
        fprintf(stderr, "FATAL: Cannot get the ClassFactory!\n");
	exit(-1);
    }

    // Load some parameters for the robot SCITOS-G5.
    ParameterNode tRobotCfg("RobotCfg");
    //if (tRobotCfg.readFromFile(MString(getMetraLabsRootDir())+
	    //"/MLRobotic/etc/config/SCITOS-G5_without_Head_config.xml") != OK)
    if (tRobotCfg.readFromFile("/home/astro/simon_listens/navigator/scitos.xml") != OK)
    {
	fprintf(stderr, "FATAL: Can't read parameter file.\n");
	exit(-1);
    }

    ///////////////////////////////////////////////////////////////////////////

    // Get the blackboard
    Blackboard* tBlackboard = tApp->getBlackboard();
    if (tBlackboard == NULL) {
        fprintf(stderr, "FATAL: Cannot get the Blackboard!\n");
	exit(-1);
    }

    ///////////////////////////////////////////////////////////////////////////
    // Robot creation and start-up

    // Create the robot interface for SCITOS-G5.
    Robot* tRobot = createInstance<Robot>(tClassFactory,
					  "b07fb034-83c1-446c-b2df-0dd6aa46eef6");
    if (tRobot == NULL) {
	fprintf(stderr, "FATAL: Failed to create the robot. Abort!\n");
	exit(-1);
    }

    // Pre-Initialize the robot
    int retVal = tRobot->preInitializeClient(&tRobotCfg);
    switch (retVal) {
        case ERR_FAILED:
                kWarning() << "The requested operation failed";
                break;
        case ERR_UNKNOWN:
                kWarning() << "Unknown error";
                break;
    }
        
    if (retVal != OK) {
	fprintf(stderr, "FATAL: Failed to pre-initialize the robot.\n");
	exit(-1);
    }

    // Assign robot to blackboard
    tRobot->setPhysicalName("Robot",                  "MyRobot");
    tRobot->setPhysicalName("BatteryState",           "MyRobot.BatteryState");
    tRobot->setPhysicalName("Drive.Odometry",         "MyRobot.Odometry");
    tRobot->setPhysicalName("Drive.VelocityCmd",      "MyRobot.VelocityCmd");
    tRobot->setPhysicalName("RangeFinder.Sonar.Data", "MyRobot.Sonar");
    tRobot->setPhysicalName("Bumper.Bumper.Data",     "MyRobot.Bumper");
    tRobot->setPhysicalName("Bumper.Bumper.ResetCmd", "MyRobot.BumperResetCmd");
    if (tRobot->assignToBlackboard(tBlackboard, true) != OK) {
	fprintf(stderr, "FATAL: Failed to assign the robot to the blackboard.\n");
	exit(-1);
    }

    // Initialize the robot
    if (tRobot->initializeClient(&tRobotCfg) != OK) {
	fprintf(stderr, "FATAL: Failed to initialize the robot.\n");
	exit(-1);
    }

    ///////////////////////////////////////////////////////////////////////////
    // Blackboard activation

    // Start the blackboard.
    if (tBlackboard->startBlackboard() != OK) {
	fprintf(stderr, "FATAL: Failed to start the blackboard.\n");
	exit(-1);
    }

    ///////////////////////////////////////////////////////////////////////////
    // Battery state callback registration

    BlackboardDataBatteryState* tBatteryState = NULL;
    tErr = getDataFromBlackboard<BlackboardDataBatteryState>(tBlackboard, 
	     "MyRobot.BatteryState", tBatteryState);
    if (tErr != OK) {
	fprintf(stderr, "FATAL: Failed to get the battery state data from the blackboard!\n");
	exit(-1);
    }
    BatteryStateCallbackHandler tBatteryStateHandler;
    tBatteryState->addCallback(&tBatteryStateHandler);

    ///////////////////////////////////////////////////////////////////////////
    // Odometry callback registration

    BlackboardDataOdometry* tOdometryData = NULL;
    tErr = getDataFromBlackboard<BlackboardDataOdometry>(tBlackboard, 
	     "MyRobot.Odometry", tOdometryData);
    if (tErr != OK) {
	fprintf(stderr, "FATAL: Failed to get the odometry data from the blackboard!\n");
	exit(-1);
    }
    OdometryCallbackHandler tOdometryHandler;
    tOdometryData->addCallback(&tOdometryHandler);

    ///////////////////////////////////////////////////////////////////////////
    // Sonar callback registration
/*

    BlackboardDataRange* tRangeData = NULL;
    tErr = getDataFromBlackboard<BlackboardDataRange>(tBlackboard, 
	     "MyRobot.Sonar", tRangeData);
    if (tErr != OK) {
	fprintf(stderr, "FATAL: Failed to get the range data from the blackboard!\n");
	exit(-1);
    }

    SonarCallbackHandler tSonarHandler;
    tRangeData->addCallback(&tSonarHandler);
*/

    ///////////////////////////////////////////////////////////////////////////

    // Start the robot.
    if (tRobot->startClient() != OK) {
	fprintf(stderr, "FATAL: Failed to start the robot system.\n");
	exit(-1);
    }

    ///////////////////////////////////////////////////////////////////////////
    // The "application"

    BlackboardDataVelocity* tVelocityData = NULL;
    tErr = getDataFromBlackboard<BlackboardDataVelocity>(tBlackboard, 
	     "MyRobot.VelocityCmd", tVelocityData);
    if (tErr != OK) {
	fprintf(stderr, "FATAL: Failed to get the velocity data from the blackboard!\n");
	exit(-1);
    }

    KAboutData aboutData( "navigator", "navigator",
        ki18n("navigator"), "0.1",
        ki18n("About data goes here"),
        KAboutData::License_GPL,
        ki18n("Copyright (c) Metralabs; Changes by Peter Grasch <grasch@simon-listens.org> (2011)") );


    QCoreApplication app(pArgc, pArgv);
    //Navigator d(0);
    Navigator d(tBlackboard);
    app.exec();

    ///////////////////////////////////////////////////////////////////////////
    // Shutdown

    // Stop the blackboard.
    if (tBlackboard->stopBlackboard() != OK)
	fprintf(stderr, "ERROR: Failed to stop the blackboard.\n");

    // Stop the robot.
    if (tRobot->stopClient() != OK)
	fprintf(stderr, "ERROR: Failed to stop the robot system.\n");

    // Destroy the robot
    if (tRobot->destroyClient() != OK)
	fprintf(stderr, "ERROR: Failed to destroy the robot system.\n");

    return(0);
}
