/**
 * @file pointer_test.cpp
 * @author Nhat Minh (nhatminh.cdt@gmail.com)
 * @brief Contain functions of how pointers could be used
 * @ref https://iamsorush.com/posts/weak-pointer-cpp/
 * @todo Fix memory errors checked by Valgrind
 * @version 0.1
 * @date 2022-09-05
 * 
 * @copyright Copyright (c) 2022
 * 
 */

/**
 * @brief include
 * 
 */
#include <iostream>
#include <memory>
#include <functional>
#include <string>

using std::function;
using std::cout;
using std::endl;
using std::string;
using std::shared_ptr;
using std::weak_ptr;
using std::make_shared;

function<void()> GetTeamName;

//  Demo of weak pointer and Lambda
struct Person;
/**
 * @brief Struct of Team
 * 
 */
struct Team{
  explicit Team(const string &n = ""):name{n} {cout << "Team created." << endl;}
  ~Team() {cout << "Team destructed." << endl;}

 public:
  shared_ptr<Person> goalKeeper;
  const string getName() {
    return name;
  }

 private:
  string name;
};
/**
 * @brief Struct of Person
 * 
 */
struct Person{
  explicit Person(const string &n = ""):name{n} {cout << "Person created." << endl;}
  ~Person() {cout << "Person destructed." << endl;}

 public:
  //  Circular dependency of shared pointers makes destructors are not called and we have a memory leak
  shared_ptr<Team> team;

  const string getName() {
    return name;
  }

 private:
  string name;
};
/**
 * @brief Adding player function
 * 
 */
void AddPlayerFunc() {
  auto f_team = make_shared<Team>("Barca");
  auto player = make_shared<Person>("Valdes");

  f_team->goalKeeper = player;
  player->team = f_team;
  cout << "===Player name: " << player->getName() << endl;

  //  Weak pointer captured by Lambda
  weak_ptr<Team> playerTeam(player->team);
  GetTeamName = [playerTeam]() {
    // Has to be copied into a shared_ptr before usage
    if (playerTeam.expired() == true) {
      cout << "Team is expired" << endl;
    }  else {
      auto team = playerTeam.lock();
      cout << "===Team: " << team->getName() << endl;
    }
  };
  GetTeamName();
}
/**
 * @brief Test leaked memory when using pointer
 * 
 * @return int 
 */
int pointer_memory_leaked_test() {
  //  Demo of weak pointer and Lambda
  AddPlayerFunc();
  GetTeamName();

  return 0;
}
