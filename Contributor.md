# Contributing Guidelines

This documentation contains a set of guidelines to help you during the contribution process.
We are happy to welcome all the contributions from anyone willing to improve/add new scripts to this project.
Thank you for helping out and remember, **no contribution is too small.**

# Color Codes 🎨
#### Primary Color:
1. ![#def7ec](https://via.placeholder.com/15/def7ec/000000?text=+) `Primary 100`
2. ![#bcf0da](https://via.placeholder.com/15/bcf0da/000000?text=+) `Primary 200`
3. ![#84e1bc](https://via.placeholder.com/15/84e1bc/000000?text=+) `Primary 300`
4. ![#31c48d](https://via.placeholder.com/15/31c48d/000000?text=+) `Primary 400`
5. ![#0d9f6e](https://via.placeholder.com/15/0d9f6e/000000?text=+) `Primary 500`
6. ![#057a55](https://via.placeholder.com/15/057a55/000000?text=+) `Primary 600`
7. ![#046c4e](https://via.placeholder.com/15/046c4e/000000?text=+) `Primary 700`
8. ![#03543F](https://via.placeholder.com/15/03543F/000000?text=+) `Primary 800`
9. ![#014737](https://via.placeholder.com/15/014737/000000?text=+) `Primary 900`

#### Secondary Color:
1. ![#FBFAFC](https://via.placeholder.com/15/FBFAFC/000000?text=+) `Primary 100`
2. ![#F7F5FA](https://via.placeholder.com/15/F7F5FA/000000?text=+) `Primary 200`
3. ![#F1EDF7](https://via.placeholder.com/15/F1EDF7/000000?text=+) `Primary 300`
4. ![#DFDAE8](https://via.placeholder.com/15/DFDAE8/000000?text=+) `Primary 400`
5. ![#BFB8CC](https://via.placeholder.com/15/BFB8CC/000000?text=+) `Primary 500`
6. ![#9187A1](https://via.placeholder.com/15/9187A1/000000?text=+) `Primary 600`
7. ![#7D728F](https://via.placeholder.com/15/7D728F/000000?text=+) `Primary 700`
8. ![#6A5F7A](https://via.placeholder.com/15/6A5F7A/000000?text=+) `Primary 800`
9. ![#453C52](https://via.placeholder.com/15/453C52/000000?text=+) `Primary 900`

## Need some help regarding the basics?🤔


- We are shifting to <a href="#"><img alt="next.js" src="https://img.shields.io/badge/next.js-000.svg?&style=for-the-badge&logo=next.js&logoColor=fff" />&nbsp;</a> for #CITIZEN.
- Do styling changes in ![TailwindCSS](https://img.shields.io/badge/tailwindcss-%2338B2AC.svg?style=for-the-badge&logo=tailwind-css&logoColor=white).
- For working with API you can refer to this [documentation](https://sandbox.abdm.gov.in/abdm-docs/BuildingPHRApp).


## Submitting Contributions👩‍💻👨‍💻

Below you will find the process and workflow used to review and merge your changes.

### Step 0 : Find an issue

- Take a look at the Existing Issues or create your **own** Issues!
- Wait for the Issue to be assigned to you after which you can start working on it.
- Note : Every change in this project should/must have an associated issue.
![Screenshot from 2024-03-21 20-37-57](https://github.com/Lobi29/mern-project/assets/108052802/6d185acd-12b9-49ad-9899-b07a61c272b3)


### Step 1 : Fork the Project

- Fork this Repository. This will create a Local Copy of this Repository on your Github Profile.
Keep a reference to the original project in `upstream` remote.  

```bash
git clone https://github.com/<your-username>/<repo-name>  
cd <repo-name>  
git remote add upstream https://github.com/<upstream-owner>/<repo-name>  
```  
![Screenshot from 2024-03-21 20-40-05](https://github.com/Lobi29/mern-project/assets/108052802/e618853c-2d40-468b-8628-cdbe36f4daf0)



- If you have already forked the project, update your copy before working.

```bash
git remote update
git checkout <branch-name>
git rebase upstream/<branch-name>
```  

### Step 2 : Branch

Create a new branch. Use its name to identify the issue your addressing.

```bash
# It will create a new branch with name Branch_Name and switch to that branch 
git checkout -b branch_name
```

### Step 3 : Local Setup

- Run Project

```bash
# It will install all the dependencies
npm install

# it will run the server
npm run server

# in another tab:
#it will run your application in localhost:4000
npm run re:watch
```

- Build for Production

```bash
npm run clean
npm run build
npm run webpack:production
```

- Note : You should have Node v12 setup on your device.

### Step 4 : Work on the issue assigned

- Work on the issue(s) assigned to you.
- Add all the files/folders needed.
- After you've made changes or made your contribution to the project add changes to the branch you've just created by:

```bash  
# To add all new files to branch Branch_Name  
git add .  

# To add only a few files to Branch_Name
git add <some files>
```

### Step 5 : Commit

- To commit give a descriptive message for the convenience of reviewer by:

```bash
# This message get associated with all files you have changed  
git commit -m "message"  
```

- **NOTE**: A PR should have only one commit. Multiple commits should be squashed.

### Step 6 : Work Remotely

- Now you are ready to your work to the remote repository.
- When your work is ready and complies with the project conventions, upload your changes to your fork:

```bash  
# To push your work to your remote repository
git push -u origin Branch_Name
```

- Here is how your branch will look.
![Screenshot from 2024-03-21 20-57-07](https://github.com/Lobi29/mern-project/assets/108052802/4d3cc636-8ce0-490b-b009-a3dc47f2cb6a)


### Step 7 : Pull Request

- Go to your repository in browser and click on compare and pull requests.
Then add a title and description to your pull request that explains your contribution.  
![Screenshot from 2024-03-21 20-58-58](https://github.com/Lobi29/mern-project/assets/108052802/17fe157e-35ac-4fa5-9c7b-5c7df0a7130d)


- Voila! Your Pull Request has been submitted and will be reviewed by the moderators and merged.🥳
    

### Tip from us😇

It always takes time to understand and learn. So, do not worry at all. We know **you have got this**!💪
